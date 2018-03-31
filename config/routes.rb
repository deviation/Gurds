Rails.application.routes.draw do

  get 'sessions/new'

  get 'home/index'

  #Our Session login routes 
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :products, :vehicles, :employees, :contracts, 
  :customercontacts, :customernotes, :orders, :order_products, :generate_orders, :routes,
  :load_orders, :customer_portals

  #Custom Routes
  #--------------------------------
  #Customer Custom Routes
  resources :customers do
    get :contacts, on: :member
    
  end

  resources :customers do
    get :notes, on: :member
    
  end
  root 'home#index'
 
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
