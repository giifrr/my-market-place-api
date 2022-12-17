require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  describe "GET /index" do
    let(:user) { FactoryBot.create(:user, password: "Ini-2000-Password") }

    context "#show action" do
      it "should show user" do
        get api_v1_user_path(user), as: :json
        json_response = JSON.parse(response.body)

        expect(json_response['email']).to eq(user.email)
        expect(response).to have_http_status(:success)
      end
    end
  end
end
