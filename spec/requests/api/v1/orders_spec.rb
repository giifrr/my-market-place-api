require 'rails_helper'

RSpec.describe "Api::V1::Orders", type: :request do
  before do
    @user = create(:user, password: "Ini-123-Pw")
    @order = create(:order, user: @user)
  end

  describe "GET /index" do
    it "should forbid order list for unlogged" do
      get api_v1_orders_path, as: :json
      expect(response).to have_http_status(:forbidden)
    end

    it "should show order list" do
      get api_v1_orders_path, headers: { Authorization: JsonWebToken.encode(user_id: @order.user.id)}, as: :json

      expect(response).to have_http_status(:success)
      expect(@order.user.orders.count).to eq(response_json.dig("data").count)
    end
  end
end
