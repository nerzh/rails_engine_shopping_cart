class ShoppingCart::ViewsGenerator < Rails::Generators::Base
  source_root File.expand_path("../../../../../app/views", __FILE__)

  def copy_views
    directory 'shopping_cart', 'app/views/shopping_cart'
  end
end