FactoryBot.define do
  factory :user do
    email { "gifar@ex.com" }
    username { "gifartest" }
    password_digest { "password" }
    first_name { "Gifar" }
    last_name { "Al Anshar" }
  end

  factory :invalid_user, parent: :user do
    email { nil }
    username { nil }
    password_digest { "password" }
    first_name { "Gifar" }
    last_name { "Al Anshar" }
  end
end
