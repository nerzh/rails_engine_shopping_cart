module ShoppingCart
  class CheckoutController < ApplicationController
    before_action :authenticate_user!

    include Wicked::Wizard
    include CartProcessor
    steps :address, :delivery, :payment, :confirm, :complete, :delete

    before_action -> { redirect_to main_app.shop_index_path if wrong_checkout_path? }
    before_action -> { redirect_to checkout_path(:address)  if wrong_complete_path? }

    def show
      if order = get_order
        @checkout_form = CheckoutForm.new(current_user, order: order, session: session)
      else
        if step == :complete
          @checkout_form = CheckoutForm.new(current_user, order: current_user.orders.last)
          render_wizard and return
        end
        @checkout_form = CheckoutForm.new(current_user, order: order, session: session)
        clear_cart
      end

      render_wizard
    end

    def update
      case step
        when :address
          checkout_form = CheckoutForm.new(current_user, order: get_order, params: params, step: step).apply_parameters
          (jump_to(step) and render_wizard and return) unless checkout_form.save
        when :confirm
          get_order.shipping!
        else
          jump_to(:address) and render_wizard and return unless session[:cart].empty?
          checkout_form = CheckoutForm.new(current_user, order: get_order, params: params, step: step).apply_parameters
          jump_to(step) unless checkout_form.save
      end
      render_wizard current_user
    end

    def destroy
      get_order&.delete
      redirect_to main_app.root_path
    end
  end
end