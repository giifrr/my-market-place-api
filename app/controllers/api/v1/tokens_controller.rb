class Api::V1::TokensController < ApplicationController
  def create
    @user = User.find_by_email(params[:user][:email])

    if @user&.authenticate(params[:user][:password])
      render json: {
        token: JsonWebToken.encode(user_id: @user.id),
        email: @user.email
      }
    else
      head :unauthorized
    end
  end
end
