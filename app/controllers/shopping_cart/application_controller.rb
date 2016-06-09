# require_dependency "shopping_cart/application_controller"

module ShoppingCart
  class ApplicationController < ::ApplicationController
    protect_from_forgery with: :exception

    before_action :merge_abilities

    private

    def merge_abilities
      current_ability.merge(ShoppingCart::Ability.new(current_user))
    end

  end
end
