# frozen_string_literal: true

class ProductSerializer
  include JSONAPI::Serializer
  attributes :name, :price, :description, :published
  belongs_to :user
end
