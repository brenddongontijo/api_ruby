Rails.application.routes.draw do
  root 'application#index'

  resources :products

  get 'products/:id/freight', to: 'products#get_freight'

end
