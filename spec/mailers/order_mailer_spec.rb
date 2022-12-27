# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderMailer, type: :mailer do
  before do
    @user = create(:user)
    @product = create(:product)
    @order_params = {
      order: {
        product_ids_and_quantities:
        [
          { product_id: @product.id, quantity: 2 }
        ]
      }
    }
    @order = Order.create(user: @user)
    @order.build_placements_with_product_ids_and_quantities(@order_params[:order][:product_ids_and_quantities])
  end

  describe 'send_confirmation' do
    it 'should be set to be delivered to the user from the order passed in' do
      mail = OrderMailer.send_confirmation(@order)
      expect('Order Confirmation').to eq(mail.subject)
      expect([@order.user.email]).to eq(mail.to)
      expect(['no-reply@mymarketplace.com']).to eq(mail.from)
      expect(mail.body.encoded).to match("Order: ##{@order.id}")
    end
  end
end
