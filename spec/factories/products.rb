# frozen_string_literal: true

# note this product is associated by first user, so all of the products is associated with first user
FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Product #{n}" }
    price { Faker::Commerce.price(range: 1..10) }
    description { Faker::Lorem.sentences(number: 1) }
    published { false }
    quantity { 10 }
    user { User.first }
  end
end
