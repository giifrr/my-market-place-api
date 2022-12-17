class UserSerializer
  include JSONAPI::Serializer
  attributes :email, :username, :first_name, :last_name
end
