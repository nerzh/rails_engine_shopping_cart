module ShoppingCart
  class BillingAddress < ActiveRecord::Base
    belongs_to :user, class_name: ShoppingCart.user_model
    belongs_to :country

    validates :first_name, :last_name, :street, :city, :zip, :phone, presence: true
  end
end
