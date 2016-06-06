class Country < ActiveRecord::Base
  has_one :shipping_address
  has_one :billing_address
  has_one :order_shipping_address
  has_one :order_billing_address
end
