class OrderBillingAddress < ActiveRecord::Base
  belongs_to :order
  belongs_to :country

  validates :first_name, :last_name, :street, :city, :zip, :phone, presence: true
end
