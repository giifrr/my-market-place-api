class Product < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 100, minimum: 3 }
end
