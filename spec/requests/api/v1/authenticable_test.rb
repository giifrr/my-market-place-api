require 'rails_helper'

class MockController
  include Authenticable
  attr_accessor :request

  def initialize
    mock_data = Struct.new(:headers)
    self.request = mock_data.new({})
  end
end

RSpec.describe "Api::V1:Authenticable", type: :request do
  before do
    @user = FactoryBot.create(:user, password: "Ini-2000-Password")
    @authentication = MockController.new
  end

  describe "GET user" do
    let(:user) { FactoryBot.create(:user, password: "Ini-2000-Password") }

    context "Authorization" do
      it "should get user from Authorization" do
        @authentication.request.headers["Authorization"] = JsonWebToken.encode(user_id: @user.id)
        expect(@authentication.current_user).to be_truthy
        expect(@authentication.current_user.id).to eq(@user.id)
      end

      it "should not get user from empty Authorization" do
        @authentication.request.headers["Authorization"] = nil
        expect(@authentication.current_user).to be_falsy
      end
    end
  end
end

