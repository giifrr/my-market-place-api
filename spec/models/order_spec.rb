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
end
