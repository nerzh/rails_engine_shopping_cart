# require_relative '../../lib/test_lib/slim_form_object'
module ShoppingCart
  class SettingsForm
    include SlimFormObject
    set_model_name 'User'

    validate :validation_models

    init_models ShoppingCart.user_model, BillingAddress, ShippingAddress, CreditCard

    def initialize(current_user, params: {})
      self.user             = current_user
      self.billing_address  = BillingAddress.new  unless self.billing_address  = current_user.billing_address
      self.shipping_address = ShippingAddress.new unless self.shipping_address = current_user.shipping_address
      self.credit_card      = CreditCard.new      unless self.credit_card      = current_user.credit_card

      self.params           = params
    end

  end
end


