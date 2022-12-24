# frozen_string_literal: true

FactoryBot.define do
  # this factory for create list of users
  factory :user do
    sequence(:email) { |n| "email#{n}@.com" }
    sequence(:username) { |n| "username#{n}" }
    password { 'Ini-123' }
    password_digest { BCrypt::Password.create('Ini-123').to_s }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end

  factory :user1, parent: :user do
    email { 'user1@ex.com' }
    username { 'user1' }
    password { 'Ini-123' }
    password_digest { BCrypt::Password.create('Ini-123').to_s }
  end

  factory :user2, parent: :user do
    email { 'user2@ex.com' }
    username { 'user2' }
    password { 'Ini-123' }
    password_digest { BCrypt::Password.create('Ini-123').to_s }
  end
end
