# rails_engine_shopping_cart

Simple Ruby On Rails plugin based on Rails Engine

## Installation
Add this line to your application gemfile

```ruby
  gem 'shopping_cart', git: 'https://github.com/woodcrust/rails_engine_shopping_cart.git'
```
and then execute:
```
  $ bundle install
```

## Usage

### Initialization

Add to your `app/controller/application_controller.rb` method current_user or use gem Devise.

Add to your config/routes.rb
```ruby
  mount ShoppingCart::Engine, at: '/' or other path
```

Add migrations:

```ruby
  rake railties:install:migrations
  rake db:migrate
```

Add to your User model:

e.g. User
```ruby
  class User < ActiveRecord::Base
    this_is_user
  end
```

Add to your product models:

e.g. Book
```ruby
  class Book < ActiveRecord::Base
    this_is_product
  end
```

Create data of your countries and delivery options:
```ruby
  rails c
  ShoppingCart::Country.create(name: '...')
  ShoppingCart::Delivery.create(name: '...', price: '...')
  p.s. price of database in coins 1/100

  or create rake task for them
```

###Helpers

* shopping_cart.cart_path                                              - cart_path
* shopping_cart.add_cart_path(product), method: 'POST'                 - add to cart button
* shopping_cart.cart_path, method: "PATCH"                             - update cart
* shopping_cart.cart_path(stat: 0, id: product[:id]), method: 'DELETE' - delete product in cart
* shopping_cart.cart_path(stat: 1), method: 'DELETE'                   - clear cart
* shopping_cart.checkout_path                                          - checkout_path
* shopping_cart.orders_path                                            - order list path

###Generators

You can change engine:

rails generate shopping_cart:controllers
rails generate shopping_cart:views


This project rocks and uses MIT-LICENSE.



