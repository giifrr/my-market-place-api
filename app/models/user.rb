class User < ApplicationRecord
  # for simplicity i'm using @ for validate an email
  validates :email, presence: true, uniqueness: true, format: {with: /@/}
  validates :username, presence: true, length: { minimum: 5, maximum: 20 }, uniqueness: true
end
