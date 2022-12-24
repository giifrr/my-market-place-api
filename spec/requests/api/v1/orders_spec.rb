# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Orders', type: :request do
  before do
    @product1, @product2 = create_list(:product, 2)
    @order = create(:order1, products: [@product1, @product2])
    @placement = create(:placement, order: @order, product: @product1)
    @placement = create(:placement, order: @order, product: @product2)
    @order_params = {
      order: {
        product_ids_and_quantities:
        [
          { product_id: @product1.id, quantity: 2 },
          { product_id: @product2.id, quantity: 3 }
        ]
      }
    }
  end

  describe 'GET /index' do
    it 'should forbid order list for unlogged' do
      get api_v1_orders_path, as: :json
      expect(response).to have_http_status(:forbidden)
    end

    it 'should show order list' do
      get api_v1_orders_path, headers: { Authorization: JsonWebToken.encode(user_id: @order.user.id) }, as: :json

      expect(response).to have_http_status(:success)
      expect(@order.user.orders.count).to eq(response_json['data'].count)
    end
  end

  describe 'GET #show' do
    it 'should show spesific order product' do
      get api_v1_order_path(@order), headers: { Authorization: JsonWebToken.encode(user_id: @order.user.id) }, as: :json

      expect(response).to have_http_status(:success)
      expect(@order.products.first.name).to eq(response_json.dig('included', 0, 'attributes', 'name'))
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
