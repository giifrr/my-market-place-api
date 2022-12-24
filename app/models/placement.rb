class Placement < ApplicationRecord
  belongs_to :order
  belongs_to :product, inverse_of: :placements

  after_save :decrement_product_quantity

  def decrement_product_quantity
    binding.break
    product.decrement!(:quantity, quantity)
  end
end
