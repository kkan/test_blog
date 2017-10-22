Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts, only: [:create] do
    get :top, on: :collection
    get :multiuser_ip_addresses, on: :collection
  end
  resources :reviews, only: [:create]
end
