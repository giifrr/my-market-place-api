require "rails_helper"

RSpec.describe OrderMailer, type: :mailer do
  before do
    @user = create(:user, password: "Ini-123")
    @product = create(:product, user: create(:user))
    @order = create(:order, user: create(:user, password: "Ini-123"), product_ids: [@product.id])
    @placement = create(:placement, product: @product, order: @order)
  end

  describe "send_confirmation" do
    it "should be set to be delivered to the user from the order passed in" do
      mail = OrderMailer.send_confirmation(@order)
      expect("Order Confirmation").to eq( mail.subject)
      expect([@order.user.email]).to eq( mail.to)
      expect(['no-reply@mymarketplace.com']).to eq(mail.from)

      expect(mail.body.encoded).to match("Order: ##{@order.id}")
    end
  end

end
