require 'rails_helper'

RSpec.describe Order, type: :model do
  it "should have positive total" do
    order = create(:order, user: create(:user, password: "Ini-2000-Password"))
    order.total = -1

    expect(order).to_not be_valid
  end
end
