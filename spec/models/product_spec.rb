require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "product name validation" do
    let(:product) { FactoryBot.build(:product) }

    context "when length product" do
      it "valid product if length product greater than 3 and less than 101" do
        product.name = "PS 5"
        expect(product).to be_valid
      end

      it "invalid product if length product greater than 100 or less than 3" do
        product.name = "PS"
        expect(product).to_not be_valid

        product.name = "P"*101
        expect(product).to_not be_valid
      end
    end

    describe "product price validation" do
      context "when product price" do
        it "valid if product price not negative" do
          product.price = 100
          expect(product).to be_valid
        end

        it "invalid if product price negative" do
          product.price = -1
          expect(product).to_not be_valid
        end
      end
    end
  end
end
