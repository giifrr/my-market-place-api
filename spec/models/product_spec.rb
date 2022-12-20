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

    describe "search product" do
        it "finds a searched product by name" do
          @user, @user2 = create_list(:user, 2)
          @product_1, @product_2, @product_3 = create_list(:product, 3)
          params = { q: "Product"}
          @q = Product.ransack(params[:q])
          @result = @q.result(distinct: true)
          expect(@result).to include(@product_1)
        end
    end
  end
end
