# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'email validation' do
    let(:user) { FactoryBot.create(:user, password: 'Ini-2000-Password') }

    it 'should have valid email' do
      expect(user).to be_valid
    end

    it 'valid if email is invalid' do
      user.email = 'abcd.com'
      expect(user).to_not be_valid
    end

    it 'invalid if email has already been taken' do
      new_user = User.new(email: user.email, password: 'Ini-2000-Password')

      expect(new_user).to_not be_valid
    end
  end

  describe 'username validation' do
    let(:user) { FactoryBot.create(:user, password: 'Ini-2000-Password') }

    context 'username presence' do
      it 'valid if username present' do
        expect(user).to be_valid
      end

      it 'invalid user if username not present' do
        user.username = nil
        expect(user).to_not be_valid
      end
    end

    context 'username length' do
      it 'valid if username length greater than 4 and less than 21 (5 <= username <= 20) ' do
        expect(user).to be_valid
      end

      it 'invalid if username length less than 5' do
        user.username = 'a' * 4
        expect(user).to_not be_valid
      end

      it 'invalid if username length greater than 20' do
        user.username = 'a' * 21
        expect(user).to_not be_valid
      end
    end

    context 'username uniqueness' do
      it 'valid if username uniq' do
        expect(user).to be_valid
      end

      it 'invalid if username not uniq' do
        new_user = FactoryBot.build(:user, email: 'test@ex.com', username: user.username, password: 'Ini-2000-Password')
        expect(new_user).to_not be_valid
      end
    end
  end

  describe 'password validation' do
    let(:user) { FactoryBot.build(:user) }

    context 'format password validation' do
      it 'valid if password is valid' do
        user.password = 'Ini-2000-Password'
        expect(user).to be_valid
      end

      it 'invalid if password is invalid' do
        user.password = 'abcd' # user password don't have uppercase, special characters, and numbers
        expect(user).to_not be_valid

        user.password = 'Abcd-' # user password don't  special characters and numbers
        expect(user).to_not be_valid
      end
    end

    context 'length password validation' do
      it 'valid if password length greater than 5 and less than 20' do
        user.password = 'Ini-2000-Password'
        expect(user).to be_valid
      end

      it 'invalid if password length less than 6' do
        user.password = 'I-2pP'
        expect(user).to_not be_valid
      end
    end
  end

  describe 'firs_name adn last_name validation' do
    let(:user) { FactoryBot.create(:user, first_name: nil, last_name: nil, password: 'Ini-2000-Pw') }

    it 'first_name should be Anonymous by default' do
      expect(user.first_name).to eq('Anonymous')
    end
  end
end
