class User < ApplicationRecord
  # for simplicity i'm using @ for validate an email
  validates :email, presence: true, uniqueness: true, format: {with: /@/}

end
