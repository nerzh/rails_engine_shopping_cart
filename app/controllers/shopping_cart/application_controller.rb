module ShoppingCart
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    def get_order
      Order.where(user_id: current_user.id, aasm_state: 'in_progress').first if current_user
    end
  end
end
