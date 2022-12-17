FactoryBot.define do
  factory :user do
    email { "gifar@ex.com" }
    username { "gifartest" }
    password_digest { "password" }
    first_name { "Gifar" }
    last_name { "Al Anshar" }
  end
end
