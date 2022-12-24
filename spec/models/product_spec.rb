# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'product name validation' do
    let(:product) { build(:product, user: create(:user)) }

    context 'when length product' do
      it 'greater than 3 and less than 101 then valid' do
        product.name = 'PS 5'
        expect(product).to be_valid
      end

      it 'greater than 100 or less than 3 then invalid' do
        product.name = 'PS'
        expect(product).to_not be_valid

        product.name = 'P' * 101
        expect(product).to_not be_valid
      end
    end

    describe 'product price validation' do
      context 'when product price' do
        it 'not negative then valid' do
          product.price = 100
          expect(product).to be_valid
        end

        it 'price negative then invalid' do
          product.price = -1
          expect(product).to_not be_valid
        end
      end
    end

    describe 'search product' do
      before do
        @user = create(:user, products: create_list(:product, 3))
        @user2 = create(:user, products: create_list(:product, 2))
        @product = @user.products.first
      end

      it 'finds a searched product by name' do
        params = { q: { product_name_cont: @product.name.to_s } }
        @q = Product.ransack(params[:q])
        @result = @q.result(distinct: true)
        expect(@result).to include(@product)
      end

      it 'finds a searched product by username' do
        params = { q: { user_username_cont: @user.username.to_s } }
        @q = Product.ransack(params[:q])
        @result = @q.result.includes(:user)
        expect(@result).to eq(@user.products)
      end
    end
  end
end
