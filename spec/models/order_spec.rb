require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @order = create(:order, user: create(:user, password: "Ini-123"))
    @product1, @product2 = create_list(:product, 2)
  end

  it "should set total" do
    order = Order.new(user_id: @order.user.id)
    order.products << @product1
    order.products << @product2
    order.save

    expect(@product1.price + @product2.price).to eq(order.total)
  end
end
