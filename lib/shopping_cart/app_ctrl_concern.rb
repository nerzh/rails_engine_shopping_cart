module ShoppingCart
  module AppCtrlConcern
    extend ActiveSupport::Concern

    def get_order
      Order.where(user_id: current_user.id, aasm_state: 'in_progress').first if current_user
    end

  end
end