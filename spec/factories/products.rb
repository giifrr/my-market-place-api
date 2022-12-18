FactoryBot.define do
  factory :product do
    user { nil }
    price { 1 }
    name { "MyString" }
    description { "MyText" }
    published { false }
  end
end
