$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "shopping_cart/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "shopping_cart"
  s.version     = ShoppingCart::VERSION
  s.authors     = ["woodcrust"]
  s.email       = ["roboucrop@gmail.com"]
  s.homepage    = "https://github.com/woodcrust/rails_engine_shopping_cart"
  s.summary     = "Summary of ShoppingCart."
  s.description = "TDescription of ShoppingCart."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency 'rails',            '~> 4.2.6'
  s.add_dependency 'slim_form_object', '~> 0.5.12'
  s.add_dependency 'aasm'
  s.add_dependency 'wicked',           '~> 1.2', '>= 1.2.1'
  s.add_dependency "haml-rails",       '~> 0.9.0'
  s.add_dependency 'sass-rails',       '~> 5.0'
  s.add_dependency 'font-awesome-sass'
  s.add_dependency 'cancancan'

  s.add_development_dependency "devise"
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'byebug'
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "shoulda-matchers"
  s.add_development_dependency "faker"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "capybara"
end
