# frozen_string_literal: true

class UserSerializer
  include JSONAPI::Serializer
  attributes :email, :username, :first_name, :last_name
  has_many :products
end
