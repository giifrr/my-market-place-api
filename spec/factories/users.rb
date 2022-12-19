# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@.com" }
    sequence(:username) { |n| "username#{n}" }
    password { 'Ini-123' }
    password_digest { BCrypt::Password.create('Ini-2000-Password').to_s }
    first_name { 'Gifar' }
    last_name { 'Al Anshar' }
  end

  factory :invalid_user, parent: :user do
    email { nil }
    username { nil }
    password_digest { BCrypt::Password.create('Ini-2000-Password').to_s }
    first_name { 'Gifar' }
    last_name { 'Al Anshar' }
  end
end
