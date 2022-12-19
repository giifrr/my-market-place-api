# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Product #{n}" }
    price { Faker::Commerce.price(range: 1..10) }
    description { Faker::Lorem.sentences(number: 1) }
    published { false }
    user { User.first }
  end
end
