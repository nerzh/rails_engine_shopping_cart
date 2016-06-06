class CheckoutForm
  include SlimFormObject
  set_model_name 'Order'

  validate :validation_models

  init_models  Order, OrderBillingAddress, OrderShippingAddress, CreditCard

  def initialize(current_user, params: {}, order: nil, session: nil)
    self.order                  = current_user.orders.create unless self.order                  = order
    self.order_billing_address  = OrderBillingAddress.new    unless self.order_billing_address  = self.order.order_billing_address
    self.order_shipping_address = OrderShippingAddress.new   unless self.order_shipping_address = self.order.order_shipping_address
    self.credit_card            = CreditCard.new             unless self.credit_card            = self.order.credit_card
    self.params                 = params

    if self.order.order_items == []
      self.order.coupon = Coupon.find_by(id: session[:coupon]['id'].to_i) if session[:coupon]&.present?
      books = Book.where(id: session[:cart].keys)
      items = []
      books.each do |book|
        items << OrderItem.new(book_id: book.id, price: book.price, quantity: session[:cart][book.id.to_s])
      end
      self.order.order_items << items
    end
  end

end