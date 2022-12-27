# frozen_string_literal: true

class Order < ApplicationRecord
  before_validation :set_total

  belongs_to :user
  has_many :placements, dependent: :destroy
  has_many :products, through: :placements

  validates_with ProductValidator
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def set_total
    self.total = placements.map { |placement| placement.quantity * placement.product.price }.sum
  end

  # this method will build the placement obejcts and once we trigger the save method for the order everything will be inserted into the database
  def build_placements_with_product_ids_and_quantities(product_ids_and_quantities)
    product_ids_and_quantities.each do |product_id_and_quantity|
      placement = placements.create(
        product_id: product_id_and_quantity[:product_id],
        quantity: product_id_and_quantity[:quantity]
      )

      placement.product.quantity -= placement.quantity
      yield placement if block_given?
    end
  end
end
