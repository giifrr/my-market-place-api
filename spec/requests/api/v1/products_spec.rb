# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Products', type: :request do
  before do
    @product = create(:product)
    @product2 = create(:product2)
  end

  describe 'GET /index' do
    it 'should get list products' do
      get api_v1_products_path, as: :json
      expect(response_json['data'].length).to eq(Product.all.length)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /api/v1/products' do
    context 'when create product' do
      it 'should create product if valid product' do
        expect do
          post api_v1_products_path,
               params: { product: { name: Faker::Commerce.name, price: Faker::Commerce.price(range: 1..10), published: true, description: 'a' * 100, user: @user } }, headers: { Authorization: JsonWebToken.encode(user_id: @product.user.id) }, as: :json
        end.to change(Product, :count).by(1)

        expect(response).to have_http_status(:created)
      end

      it 'should not create product if invalid product' do
        expect do
          post api_v1_products_path,
               params: { product: { name: Faker::Commerce.name, price: -1, published: true, description: 'a' * 100, user: @product.user.id } }, headers: { Authorization: JsonWebToken.encode(user_id: @product.user.id) }, as: :json
        end.to change(Product, :count).by(0)

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should forbid create product if unlogged' do
        expect do
          post api_v1_products_path,
               params: { product: { name: Faker::Commerce.name, price: -1, published: true, description: 'a' * 100, user: @product.user.id } }, as: :json
        end.to change(Product, :count).by(0)

        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'PATCH /api/v1/product/:id' do
    context 'when update product' do
      it "should update product if valid product" do
        patch api_v1_product_path(@product), params: { product: { name: 'update-name' } }, headers: { Authorization: JsonWebToken.encode(user_id: @product.user.id) }, as: :json

        expect(response).to have_http_status(:success)
      end

      it "should not update product if invalid product" do
        patch api_v1_product_path(@product), params: { product: { name: nil } }, headers: { Authorization: JsonWebToken.encode(user_id: @product.user.id) }, as: :json

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "should forbid update product for unlogged" do
        patch api_v1_product_path(@product), params: { product: { name: nil } }, as: :json

        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
