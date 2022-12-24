require 'rails_helper'

RSpec.describe Placement, type: :model do
  before do
    @product = create(:product, user: create(:user, password: "Ini-123"))
    @order = create(:order, user: @product.user)
    @placement = create(:placement, order: @order, product: @product)
  end

  describe "decrease quantity" do
    it "should decrease quantity by the plaecment quantity" do
      @placement.decrement_product_quantity
      expect(@product.quantity).to eq(0)
    end
  end
end
