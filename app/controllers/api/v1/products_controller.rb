# frozen_string_literal: true

module Api
  module V1
    class ProductsController < ApplicationController
      before_action :check_login, only: %i[create update]
      before_action :set_product, only: %i[update]

      def index
        @products = Product.all
        render json: ProductSerializer.new(@products).serializable_hash, status: :ok
      end

      def create
        @product = Product.new(product_params)
        @product.user_id = current_user.id

        if @product.save
          render json: ProductSerializer.new(@product).serializable_hash, status: :created
        else
          render json: @product.errors, status: :unprocessable_entity
        end
      end

      def update
        if @product.update(product_params)
          render json: ProductSerializer.new(@product).serializable_hash, status: :ok
        else
          render json: @product.errors, status: :unprocessable_entity
        end
      end

      private

      def product_params
        params.require(:product).permit(:name, :price, :description, :published)
      end

      def set_product
        @product = Product.find(params[:id])
      end
    end
  end
end
