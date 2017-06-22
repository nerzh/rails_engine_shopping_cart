module ShoppingCart
  class SettingsForm < SlimFormObject::Base
    
    set_model_name 'User'

    validate :validation_models

    init_models ShoppingCart.user_model, BillingAddress, ShippingAddress, CreditCard

    def initialize(current_user, params: {})
      super(params: parameters(params))

      self.user             = current_user
      self.billing_address  = BillingAddress.new  unless self.billing_address  = current_user.billing_address
      self.shipping_address = ShippingAddress.new unless self.shipping_address = current_user.shipping_address
      self.credit_card      = CreditCard.new      unless self.credit_card      = current_user.credit_card
    end

    private

    def parameters(params)
      return {} if params.empty?
      params.require(:user).permit(billing_address: [:first_name, :last_name, :street, :city, :country_id, :zip, :phone], 
                                   shipping_address: [:first_name, :last_name, :street, :city, :country_id, :zip, :phone], 
                                   credit_card: [:number, :cvv, :exp_year, :exp_month, :first_name, :last_name], 
                                   user_email: '')
    end
  end
end


