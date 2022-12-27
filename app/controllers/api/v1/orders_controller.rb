# frozen_string_literal: true

module Api
  module V1
    class OrdersController < ApplicationController
      include Paginable
      before_action :check_login

      def index
        @orders = current_user.orders.page(params[:current_page]).per(params[:per_page])
        options = get_links_serializer_options('api_v1_orders_path', @orders)
        render json: OrderSerializer.new(@orders, options).serializable_hash, status: :ok
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
        @order = Order.create(user: current_user)
        @order.build_placements_with_product_ids_and_quantities(order_params[:product_ids_and_quantities])

        if @order.save
          OrderMailer.send_confirmation(@order).deliver
          render json: OrderSerializer.new(@order).serializable_hash, status: :created
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      end

      private

      def order_params
        params.require(:order).permit(product_ids_and_quantities: %i[product_id quantity])
      end
    end
  end
end
