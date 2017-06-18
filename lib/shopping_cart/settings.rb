module ShoppingCart
  mattr_accessor :user_model
  mattr_accessor :product_model

  module Settings
    module Product
      def this_is_product
        ShoppingCart.product_model = self
        has_many :orders,     through: :order_items, class_name: ShoppingCart::OrderItem, foreign_key: "product_id"
        has_many :order_items,                       class_name: ShoppingCart::OrderItem, foreign_key: "product_id"
      end
    end

    module User
      def this_is_user
        ShoppingCart.user_model = self
        has_one  :shipping_address, dependent: :delete,     class_name: ShoppingCart::ShippingAddress, foreign_key: "user_id"
        has_one  :billing_address,  dependent: :delete,     class_name: ShoppingCart::BillingAddress,  foreign_key: "user_id"
        has_one  :credit_card,      dependent: :delete,     class_name: ShoppingCart::CreditCard,      foreign_key: "user_id"
        has_many :orders,           dependent: :delete_all, class_name: ShoppingCart::Order,           foreign_key: "user_id"
      end
    end
  end
end
