class ShoppingCartBillingAddresses < ActiveRecord::Migration
  def change
    create_table "shopping_cart_billing_addresses", force: :cascade do |t|
      t.string   "first_name"
      t.string   "last_name"
      t.string   "street"
      t.string   "city"
      t.integer  "country_id"
      t.string   "zip"
      t.string   "phone"
      t.integer  "user_id"
    end
  end
end
