class ShoppingCartOrders < ActiveRecord::Migration
  def change
    create_table "shopping_cart_orders", force: :cascade do |t|
      t.string   "aasm_state"
      t.integer  "total_price",   default: 0, null: false
      t.datetime "completed_date"
      t.integer  "user_id"
      t.integer  "credit_card_id"
      t.integer  "coupon_id"
      t.integer  "delivery_id"
    end
  end
end
