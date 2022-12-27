# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Tokens', type: :request do
  describe 'GET /index' do
    context 'when request tokens' do
      let(:user) { FactoryBot.create(:user1) }

      it 'should get token' do
        post api_v1_tokens_path, params: { user: { email: user.email, password: user.password } }, as: :json
        expect(response_json[:token]).to_not be_empty
      end

      it 'should get unauthorized if user not found' do
        post api_v1_tokens_path, params: { user: { email: 'abcd@c.com', password: 'Hello-123' } }, as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
