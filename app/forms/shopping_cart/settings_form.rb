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

      self.params           = parameters(params)
    end

    private

    def parameters(params)
      return {} if params.empty?
      params.require(:user).permit(:billing_address_first_name, :billing_address_last_name,   :billing_address_street,
                                   :billing_address_city,       :billing_address_country_id,  :billing_address_zip,
                                   :billing_address_phone,      :shipping_address_first_name, :shipping_address_last_name,
                                   :shipping_address_street,    :shipping_address_city,       :shipping_address_country_id,
                                   :shipping_address_zip,       :shipping_address_phone,      :credit_card_number, :credit_card_cvv,
                                   :credit_card_exp_year,       :credit_card_exp_month,       :credit_card_first_name,
                                   :credit_card_last_name,      :user_email )
    end
  end
end


