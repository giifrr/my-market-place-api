# frozen_string_literal: true

FactoryBot.define do
  factory :placement do
    order { nil }
    product { nil }
    quantity { 5 }
  end
end
