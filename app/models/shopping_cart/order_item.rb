class OrderItem < ActiveRecord::Base

  include CartItems

  belongs_to :book
  belongs_to :order

  validates  :price, :quantity, presence: true
  after_save :update_total_price_in_order

  def update_total_price_in_order
    order_items = OrderItem.where(order_id: self.order)
    total_price = 0
    order_items.each { |order_item| total_price += order_item.price*order_item.quantity }
    total_price = show_price(total_price)
    if discount = self.order.coupon&.discount
      total_price = (total_price - total_price * discount.to_d/100).round 2
    end
    self.order.update( total_price: set_price(total_price) )
  end

end