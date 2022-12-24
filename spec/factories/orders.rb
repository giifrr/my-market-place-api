# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    total { '9.99' }
    user { nil }
  end

  factory :order1, parent: :order do
    total { 10.0 }
    user { create(:user1) }
  end

  factory :order2, parent: :order do
    total { 10.0 }
    user { create(:user2) }
  end
end
