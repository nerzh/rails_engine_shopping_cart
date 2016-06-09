class ShoppingCartCoupons < ActiveRecord::Migration
  def change
    create_table "shopping_cart_coupons", force: :cascade do |t|
      t.integer  "number"
      t.integer  "discount"
    end
  end
end
