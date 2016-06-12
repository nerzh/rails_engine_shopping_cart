module ShoppingCart
  module CartProcessor
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

    def update_session_cart
      if params[:coupon] =~ /^\d+$/
        coupon = Coupon.find_by(number: params[:coupon])
        session[:coupon]['id']       = coupon&.id
        session[:coupon]['number']   = coupon&.number
        session[:coupon]['discount'] = coupon&.discount
      else
        session[:coupon]['id']       = nil
        session[:coupon]['number']   = nil
        session[:coupon]['discount'] = nil
      end
      params[:cart]&.keys&.each do |product_id|
        session[:cart].delete(product_id) and next if params[:cart][product_id] == ''
        session[:cart][product_id] = params[:cart][product_id]
      end
    end

    def destroy_product_or_clear_self
      if params[:stat] == "0"
        session[:cart].delete(params[:id]) if session[:cart].key?(params[:id])
      elsif params[:stat] == "1"
        clear_cart
      end
    end

    def clear_cart
      session[:cart].clear
      session[:coupon]&.clear
    end

    def add_to_session_cart
      unless session[:cart][params[:id]].nil?
        session[:cart][params[:id]] = session[:cart][params[:id]].to_i + params[:quantity].to_i
        redirect_to cart_path and return
      end
      session[:cart][params[:id]] = params[:quantity].to_i
    end

    def show_price(price)
      return 0.0 if price.nil?
      (price.to_d/1000).round 2
    end

    def set_price(price)
      return 0 if price.nil?
      (price*1000).to_i
    end

    def wrong_checkout_path?
      session[:cart].nil? || session[:cart].empty? and !get_order and [:address, :delivery, :payment, :confirm].include?(step)
    end

    def wrong_complete_path?
      session[:cart].nil? || session[:cart].empty? and get_order and step == :complete
    end
  end
end