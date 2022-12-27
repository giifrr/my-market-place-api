# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Products', type: :request do
  before do
    @product_1, @product_2, @product_3 = create_list(:product, 3)
  end

  describe 'GET #index' do
    it 'should get list products' do
      get api_v1_products_path, as: :json
      expect(response_json.dig(:links, :first)).to_not be_nil
      expect(response_json.dig(:links, :last)).to_not be_nil
      expect(response_json.dig(:links, :prev)).to_not be_nil
      expect(response_json.dig(:links, :next)).to_not be_nil
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /api/v1/product/id' do
    it 'should show product' do
      get api_v1_product_path(@product_1), as: :json
      product = response_json.dig(:data, :attributes, :name)

      expect(product).to eq(@product_1.name)
    end
  end

  describe 'POST /api/v1/products' do
    context 'when create product' do
      it 'should create product if valid product' do
        expect do
          post api_v1_products_path,
               params: { product: { name: Faker::Commerce.name, price: Faker::Commerce.price(range: 1..10), published: true, description: 'a' * 100, user: @user } }, headers: { Authorization: JsonWebToken.encode(user_id: @product_1.user.id) }, as: :json
        end.to change(Product, :count).by(1)

        expect(response).to have_http_status(:created)
      end

      it 'should not create product if invalid product' do
        expect do
          post api_v1_products_path,
               params: { product: { name: Faker::Commerce.name, price: -1, published: true, description: 'a' * 100, user: @product_1.user.id } }, headers: { Authorization: JsonWebToken.encode(user_id: @product_1.user.id) }, as: :json
        end.to change(Product, :count).by(0)

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should forbid create product if unlogged' do
        expect do
          post api_v1_products_path,
               params: { product: { name: Faker::Commerce.name, price: -1, published: true, description: 'a' * 100, user: @product_1.user.id } }, as: :json
        end.to change(Product, :count).by(0)

        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'PATCH /api/v1/product/:id' do
    context 'when update product' do
      it 'should update product if valid product' do
        patch api_v1_product_path(@product_1), params: { product: { name: 'update-name' } },
                                               headers: { Authorization: JsonWebToken.encode(user_id: @product_1.user.id) }, as: :json

        expect(response).to have_http_status(:success)
      end

      it 'should not update product if invalid product' do
        patch api_v1_product_path(@product_1), params: { product: { name: nil } },
                                               headers: { Authorization: JsonWebToken.encode(user_id: @product_1.user.id) }, as: :json

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should not update product if not owner' do
        patch api_v1_product_path(@product_1), params: { product: { name: 'Product not found' } },
                                               headers: { Authorization: JsonWebToken.encode(user_id: create(:user1)) }, as: :json

        expect(response).to have_http_status(:forbidden)
      end

      it 'should forbid update product for unlogged' do
        patch api_v1_product_path(@product_1), params: { product: { name: nil } }, as: :json

        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'DELETE /api/v1/product/:id' do
    context 'when delete product' do
      it 'should delete product' do
        expect do
          delete api_v1_product_path(@product_1),
                 headers: { Authorization: JsonWebToken.encode(user_id: @product_1.user.id) }, as: :json
        end.to change(Product, :count).by(-1)

        expect(response).to have_http_status(:no_content)
      end

      it 'should forbid delete product if unlogged' do
        expect do
          delete api_v1_product_path(@product_1), as: :json
        end.to change(Product, :count).by(0)

        expect(response).to have_http_status(:forbidden)
      end

      it 'should not delete product if not owner' do
        expect do
          delete api_v1_product_path(@product_1),
                 headers: { Authorization: JsonWebToken.encode(user_id: create(:user1)) }, as: :json
        end.to change(Product, :count).by(0)

        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
