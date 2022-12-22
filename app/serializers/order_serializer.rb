class OrderSerializer
  include JSONAPI::Serializer
  attributes
  has_many :products
  belongs_to :user
end
