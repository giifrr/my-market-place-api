class Api::V1::OrdersController < ApplicationController
  before_action :check_login

  def index
    @orders = current_user.orders
    render json: OrderSerializer.new(@orders).serializable_hash, status: :ok
  end
end
