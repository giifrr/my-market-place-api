class Api::V1::OrdersController < ApplicationController
  before_action :check_login

  def index
    @orders = current_user.orders
    render json: OrderSerializer.new(@orders).serializable_hash, status: :ok
  end

  def show
    @order = current_user.orders.find(params[:id])
    options = { include: [:products] }

    if @order
      render json: OrderSerializer.new(@order, options).serializable_hash, status: :ok
    else
      head 404
    end
  end
end
