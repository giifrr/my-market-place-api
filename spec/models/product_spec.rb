require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "product name" do
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
  end
end
