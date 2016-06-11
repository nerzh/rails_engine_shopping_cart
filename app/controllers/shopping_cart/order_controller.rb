module ShoppingCart
  class OrderController < ApplicationController
    before_action :authenticate_user!
    include CartItems

    def index
      @orders      = current_user&.orders
      @order       = @orders.find_by(aasm_state: 'in_progress')
      @order_items = get_items_hash(order: @order) or get_items_hash(session: session)
      @shipping    = @orders.where(aasm_state: 'shipping')
      @completed   = @orders.where(aasm_state: 'completed')
    end

    def new
      @book = ShoppingCart.product_model.find(params[:book])
      @user = current_user
    end

  end
end
