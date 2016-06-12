module ShoppingCart
  class CartController < ApplicationController
    include CartProcessor

    before_action -> { session[:cart] ||= Hash.new; session[:coupon] ||= Hash.new }

    def show
      redirect_to checkout_path(:address) and return if get_order
      @cart = get_items_hash(session: session)
    end

    def add
      add_to_session_cart
      redirect_to cart_path
    end

    def update
      update_session_cart
      redirect_to cart_path
    end

    def destroy
      destroy_product_or_clear_self
      redirect_to cart_path
    end

  end
end