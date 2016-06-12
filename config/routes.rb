ShoppingCart::Engine.routes.append do

  resource  :cart, controller: 'cart', only: [:show, :update, :destroy] do
    collection do
      post 'add'
    end
  end

  resources :orders,   controller: 'order',    only: [:index, :new]
  resources :checkout, controller: 'checkout', only: [:show, :update, :destroy]

  resource :settings, only: [:show, :update] do
    collection do
      patch 'update_password'
    end
  end

end
