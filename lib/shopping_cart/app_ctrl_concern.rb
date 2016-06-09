module ShoppingCart
  module AppCtrlConcern

    def self.included(base)

    end

    def get_order
      Order.where(user_id: current_user.id, aasm_state: 'in_progress').first if current_user
    end
  end
end