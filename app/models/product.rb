# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :user
  has_many :placements, dependent: :destroy
  has_many :orders, through: :placements

  validates :name, presence: true, length: { maximum: 100, minimum: 3 }
  validates :price, presence: true,  numericality: { greater_than_or_equal_to: 0 }
end
