class ShoppingCartCreditCards < ActiveRecord::Migration
  def change
    create_table "shopping_cart_credit_cards", force: :cascade do |t|
      t.string   "number"
      t.integer  "cvv"
      t.string   "first_name"
      t.string   "last_name"
      t.integer  "user_id"
      t.integer  "exp_month"
      t.integer  "exp_year"
    end
  end
end
