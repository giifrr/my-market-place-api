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

  describe "POST /create" do
    context "#create action" do
      it "should create a user if valid user" do
        expect do
          post api_v1_users_path, params: { user: { email: "test@example.com", username: "test1234", password: "Ini-2000-Password" } }, as: :json
        end.to change(User, :count).by(1)

        expect(response).to have_http_status(:created)
      end

      it "should not create a user if invalid user" do
        expect do
          post api_v1_users_path, params: { user: { email: "test@example.com", username: "test1234", password: "abcdefg" } }, as: :json
        end.to change(User, :count).by(0)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
