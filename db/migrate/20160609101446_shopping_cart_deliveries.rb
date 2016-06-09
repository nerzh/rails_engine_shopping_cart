class ShoppingCartDeliveries < ActiveRecord::Migration
  def change
    create_table "shopping_cart_deliveries", force: :cascade do |t|
      t.string   "name"
      t.integer  "price",      default: 0
    end
  end
end
