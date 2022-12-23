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

  def create
    @order = current_user.orders.build(order_params)

    if @order.save
      OrderMailer.send_confirmation(@order).deliver
      render json: OrderSerializer.new(@order).serializable_hash, status: :created
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(:total, product_ids: [])
  end
end
