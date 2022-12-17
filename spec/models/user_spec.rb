require 'rails_helper'

RSpec.describe User, type: :model do

  describe "User email validation" do
    let(:user) { FactoryBot.build(:user) }

    it "should have valid email" do
      expect(user).to be_valid
    end

    it "valid if email is invalid" do
      user.email = "abcd.com"
      expect(user).to_not be_valid
    end

    it "invalid if email has already been taken" do
      user = FactoryBot.create(:user)
      new_user = User.new(email: user.email)

      expect(new_user).to_not be_valid
    end
  end
end
