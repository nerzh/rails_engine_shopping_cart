class ShoppingCart::ControllersGenerator < Rails::Generators::Base
  source_root File.expand_path("../../../../../app/controllers", __FILE__)

  def copy_controllers
    directory 'shopping_cart', 'app/controllers/shopping_cart'
  end
end