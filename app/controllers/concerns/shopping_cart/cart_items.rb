module ShoppingCart
  module CartItems
    extend ActiveSupport::Concern

    def get_items_hash(order: nil, session: nil)
      return nil if order.nil? and session.nil?
      order ? items = order.order_items.pluck(:product_id, :quantity) : items = session[:cart].map{ |k,v| [k,v] }
      products_ids = items.map{ |arr| arr[0] }
      @cart = []
      products = ShoppingCart.product_model.where(id: products_ids)
      items.each do |item|
        product = products.find(item[0])

        value               = {}
        value[:id]          = product.id
        value[:title]       = product.title
        value[:description] = product.description
        value[:price]       = product.show_price
        value[:image]       = product.cover.small
        value[:amount]      = item[1].to_i
        order ? value[:total] = show_price(order.total_price) : value[:total] = product.show_price * value[:amount]
        value[:coupon] = session[:coupon]['discount'] if session and session[:coupon]&.present?

        @cart << value
      end
      @cart
    end

    def show_price(price)
      return 0.0 if price.nil?
      (price.to_d/1000).round 2
    end

    def set_price(price)
      return 0 if price.nil?
      (price*1000).to_i
    end
  end
end