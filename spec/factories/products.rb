FactoryBot.define do
  factory :product do
    user { create(:user, password: "Test-1") }
    price { Faker::Commerce.price(range: 1..10) }
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentences(number: 1) }
    published { false }
  end
end
