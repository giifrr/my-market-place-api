FactoryBot.define do
  factory :user do
    email { "gifar@ex.com" }
    username { "Apa-1234-Aja" }
    password_digest { "#{BCrypt::Password.create('Ini-2000-Password')}" }
    first_name { "Gifar" }
    last_name { "Al Anshar" }
  end

  factory :user2, parent: :user do
    email { "apaaja@gmail.com" }
    username { "apaajaya" }
    password_digest { "#{BCrypt::Password.create('Ini-2000-Password')}"}
    first_name { "Beko" }
    last_name { "Stalin" }
  end

  factory :invalid_user, parent: :user do
    email { nil }
    username { nil }
    password_digest { "#{BCrypt::Password.create('Ini-2000-Password')}" }
    first_name { "Gifar" }
    last_name { "Al Anshar" }
  end
end
