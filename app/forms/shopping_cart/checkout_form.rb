module ShoppingCart
  class CheckoutForm < SlimFormObject::Base
    # include SlimFormObject

    set_model_name 'Order'
    init_models  Order, OrderBillingAddress, OrderShippingAddress, CreditCard
    validate :validation_models

    def initialize(current_user, params: {}, order: nil, session: nil, step: nil)
      super(params: parameters(step, params))

      self.order                  = current_user.orders.create unless self.order                  = order
      self.order_billing_address  = OrderBillingAddress.new    unless self.order_billing_address  = self.order.order_billing_address
      self.order_shipping_address = OrderShippingAddress.new   unless self.order_shipping_address = self.order.order_shipping_address
      self.credit_card            = CreditCard.new             unless self.credit_card            = self.order.credit_card
      self.params                 = parameters(step, params)

      if self.order.order_items == []
        self.order.coupon = Coupon.find_by(id: session[:coupon]['id'].to_i) if session[:coupon]&.present?
        products = ShoppingCart.product_model.where(id: session[:cart].keys)
        items = []
        products.each do |product|
          items << OrderItem.new(product_id: product.id, price: product.price, quantity: session[:cart][product.id.to_s])
        end
        self.order.order_items << items
      end
    end

    private

    def parameters(step, params)
      return {} if params.empty?
      case step
        when :address
          # not_validate CreditCard
          params.require(:order).permit(order_billing_address: [:first_name, :last_name, :street, :city, :country_id, :zip, :phone], 
                                        order_shipping_address: [:first_name, :last_name, :street, :city, :country_id, :zip, :phone])
        when :delivery
          params.require(:order).permit(order: [:delivery_id])
        when :payment
          params.require(:order).permit(credit_card: [:number, :cvv, :exp_year, :exp_month, :first_name, :last_name])
      end
    end
  end
end