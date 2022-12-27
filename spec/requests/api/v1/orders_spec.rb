# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Orders', type: :request do
  before do
    @product1, @product2 = create_list(:product, 2)
    @order_params = {
      order: {
        product_ids_and_quantities:
        [
          { product_id: @product1.id, quantity: 2 },
          { product_id: @product2.id, quantity: 3 }
        ]
      }
    }
    @order = Order.create(user: create(:user))
    @order.build_placements_with_product_ids_and_quantities(@order_params[:order][:product_ids_and_quantities])
  end

  describe 'GET /index' do
    it 'should forbid order list for unlogged' do
      get api_v1_orders_path, as: :json
      expect(response).to have_http_status(:forbidden)
    end

    it 'should show order list' do
      get api_v1_orders_path, headers: { Authorization: JsonWebToken.encode(user_id: @order.user.id) }, as: :json
      expect(response).to have_http_status(:success)
      expect(@order.user.orders.count).to eq(response_json[:data].count)
      expect(response_json.dig(:links, :first)).to_not be_nil
      expect(response_json.dig(:links, :last)).to_not be_nil
      expect(response_json.dig(:links, :prev)).to_not be_nil
      expect(response_json.dig(:links, :next)).to_not be_nil
    end
  end

  describe 'GET #show' do
    it 'should show spesific order product' do
      get api_v1_order_path(@order), headers: { Authorization: JsonWebToken.encode(user_id: @order.user.id) }, as: :json

      expect(response).to have_http_status(:success)
      expect(@order.placements.first.product.name).to eq(response_json.dig('included', 0, 'attributes', 'name'))
    end
  end

  describe 'POST #create' do
    it 'should forbid create order for unlogged' do
      post api_v1_orders_path, params: @order_params, as: :json
      expect(response).to have_http_status(:forbidden)
    end

    it 'should create orders with two products and placements' do
      expect do
        expect do
          post api_v1_orders_path, params: @order_params,
                                   headers: { Authorization: JsonWebToken.encode(user_id: @order.user.id) }, as: :json
        end.to change(Placement, :count).by(2)

        expect(response).to have_http_status(:created)
      end.to change(Order, :count).by(1)
    end
  end
end
