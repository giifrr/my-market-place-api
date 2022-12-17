class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  def show
    render json: UserSerializer.new(@user).serializable_hash, status: :ok
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: UserSerializer.new(@user).serializable_hash, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: UserSerializer.new(@user).serializable_hash, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :username)
    end

    def set_user
      @user = User.find(params[:id])
    end
end
