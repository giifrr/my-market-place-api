# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :products, dependent: :destroy

  after_save :set_default_name

  # for simplicity i'm using @ for validate an email
  validates :email, presence: true, uniqueness: true, format: { with: /@/ }
  validates :username, presence: true, length: { minimum: 5, maximum: 20 }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6, maximum: 20 }, password: true

  def set_default_name
    self.first_name = 'Anonymous'
  end
end
