# frozen_string_literal: true

module Api
  module V1
    class ProductsController < ApplicationController
      before_action :check_login, only: %i[create update destroy]
      before_action :set_product, only: %i[show update destroy]
      before_action :check_owner, only: %i[update destroy]

      def index
        @products = Product.all
        options = { inlcude: [:user] }
        render json: ProductSerializer.new(@products, options).serializable_hash, status: :ok
      end

      def show
        options = { inlcude: [:user] }
        render json: ProductSerializer.new(@product, options).serializable_hash, status: :ok
      end

      def create
        @product = Product.new(product_params)
        @product.user_id = current_user.id

        if @product.save
          options = { inlcude: [:user] }
          render json: ProductSerializer.new(@product, options).serializable_hash, status: :created
        else
          render json: @product.errors, status: :unprocessable_entity
        end
      end

      def update
        if @product.update(product_params)
          options = { inlcude: [:user] }
          render json: ProductSerializer.new(@product, options).serializable_hash, status: :ok
        else
          render json: @product.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @product.destroy
        head :no_content
      end

      private

      def product_params
        params.require(:product).permit(:name, :price, :description, :published)
      end

      def set_product
        @product = Product.find(params[:id])
      end

      def check_owner
        head :forbidden unless @product.user == current_user
      end
    end
  end
end
