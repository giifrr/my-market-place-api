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

  describe "User username validation" do
    let(:user) { FactoryBot.create(:user) }

    context "username presence" do
      it "valid if username present" do
        expect(user).to be_valid
      end

      it "invalid user if username not present" do
        user.username = nil
        expect(user).to_not be_valid
      end
    end

    context "username length" do
      it "valid if username length greater than 4 and less than 21 (5 <= username <= 20) " do
        expect(user).to be_valid
      end

      it "invalid if username length less than 5" do
        user.username = "a" * 4
        expect(user).to_not be_valid
      end

      it "invalid if username length greater than 20" do
        user.username = "a" * 21
        expect(user).to_not be_valid
      end
    end

    context "username uniqueness" do
      it "valid if username uniq" do
        expect(user).to be_valid
      end

      it "invalid if username not uniq" do
        new_user = FactoryBot.build(:user, email: "test@ex.com", username: user.username)
        expect(new_user).to_not be_valid
      end
    end
  end
end
