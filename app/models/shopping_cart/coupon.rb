module ShoppingCart
  class Coupon < ActiveRecord::Base
    has_one :order
  end
end
