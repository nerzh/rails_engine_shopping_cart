class ShoppingCartCountries < ActiveRecord::Migration
  def change
    create_table "shopping_cart_countries", force: :cascade do |t|
      t.string   "name"
    end
  end
end
