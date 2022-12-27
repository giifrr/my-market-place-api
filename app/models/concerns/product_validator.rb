# frozen_string_literal: true

class ProductValidator < ActiveModel::Validator
  def validate(record)
    record.placements.each do |placement|
      product = placement.product
      if placement.quantity > product.quantity
        record.errors.add :name, "Is out of stock, just #{product.quantity} left."
      end
    end
  end
end
