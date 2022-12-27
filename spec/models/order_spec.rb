# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @order = create(:order1)
    @product1, @product2 = create_list(:product, 2)
  end

  it 'should build 2 placements for the order' do
    expect do
      @order.build_placements_with_product_ids_and_quantities([
                                                                { product_id: @product1.id, quantity: 2 },
                                                                { product_id: @product2.id, quantity: 3 }
                                                              ])
      @order.save
    end.to change(Placement, :count).by(2)
  end

  it 'should not create order if product not fit' do
    @order.placements << Placement.new(product_id: @product1.id, quantity: @product1.quantity + 1)

    expect(@order).to_not be_valid
  end

  it 'should set total' do
    @order.placements = [
      Placement.new(product_id: @product1.id, quantity: 2),
      Placement.new(product_id: @product2.id, quantity: 3)
    ]

    @order.set_total
    expected_total = (@product1.price * 2) + (@product2.price * 3)
    expect(expected_total).to eq(@order.total)
  end
end
