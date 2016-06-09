ShoppingCart::Engine.routes.append do
  resource  :cart, controller: 'cart' do
    collection do
      post 'add'
    end
  end

  resources :orders,   controller: 'order'
  resources :checkout, controller: 'checkout'

  resource :settings do
    collection do
      patch 'update_password'
    end
  end
end
