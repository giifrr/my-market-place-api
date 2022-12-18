# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'GET /index' do
    let(:user) { FactoryBot.create(:user, password: 'Ini-2000-Password') }

    context '#show action' do
      it 'should show user' do
        get api_v1_user_path(user), as: :json

        expect(response_json['data']['attributes']['email']).to eq(user.email)
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'POST /create' do
    context '#create action' do
      it 'should create a user if valid user' do
        expect do
          post api_v1_users_path,
               params: { user: { email: 'test@example.com', username: 'test1234', password: 'Ini-2000-Password' } }, as: :json
        end.to change(User, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(response_json['data']['attributes']['email']).to eq('test@example.com')
      end

      it 'should not create a user if invalid user' do
        expect do
          post api_v1_users_path,
               params: { user: { email: 'test@example.com', username: 'test1234', password: 'abcdefg' } }, as: :json
        end.to change(User, :count).by(0)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    let(:user) { FactoryBot.create(:user, password: 'Ini-2000-Password') }

    context '#update action' do
      it 'should update user' do
        patch api_v1_user_path(user), params: { user: { email: 'initest@g.com', password: 'Ini-2000-Pw' } }, headers: { Authorization: JsonWebToken.encode(user_id: user.id) }, as: :json # just change user email

        expect(response).to have_http_status(:success)
      end

      it 'should forbid update user for unlogged' do
        patch api_v1_user_path(user), params: { user: { email: 'initest.com', password: 'Ini-2000-Pw' } }, as: :json # just change user email but invalid email

        expect(response).to have_http_status(:forbidden)
      end

      it 'should not update user for invalid user' do
        patch api_v1_user_path(user), params: { user: { email: 'initest.com', password: 'Ini-2000-Pw' } }, headers: { Authorization: JsonWebToken.encode(user_id: user.id) }, as: :json # just change user email but invalid email

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /delete' do
    context '#delete action' do
      it 'should delete user' do
        user = FactoryBot.create(:user, password: 'Ini-2000-Password')

        expect do
          delete api_v1_user_path(user), headers: { Authorization: JsonWebToken.encode(user_id: user.id) }, as: :json

          expect(response).to have_http_status(:no_content)
        end.to change(User, :count).by(-1)
      end

      it 'should forbid delete user for unlogged' do
        user = FactoryBot.create(:user, password: 'Ini-2000-Password')

        expect do
          delete api_v1_user_path(user), as: :json

          expect(response).to have_http_status(:forbidden)
        end.to change(User, :count).by(0)
      end

      it 'should forbid delete user if not owner' do
        user = FactoryBot.create(:user, password: 'Ini-2000-Password')
        user2 = FactoryBot.create(:user2, password: 'Abc-123')

        expect do
          delete api_v1_user_path(user), headers: { Authorization: JsonWebToken.encode(user_id: user2.id) }, as: :json
        end.to change(User, :count).by(0)

        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
