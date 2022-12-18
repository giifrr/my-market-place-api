require 'rails_helper'

RSpec.describe "Api::V1::Products", type: :request do
  before do
    @product = create(:product)
    @product2 = create(:product2)
  end

  describe "GET /index" do
    it "should get list products" do
      get api_v1_products_path, as: :json
      expect(response_json['data'].length).to eq(Product.all.length)
      expect(response).to have_http_status(:success)
    end
  end
end
