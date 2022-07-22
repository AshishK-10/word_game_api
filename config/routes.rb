Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :keys
  # Defines the root path route ("/")

  resources :fortytwoword do
    get :word, on: :member
    get :example,on: :member
    get :defination, on: :member
    get :wordRelation, on: :member
    post :getexample,on: :member
    post :getdefination,on: :member
    post :getWordRelation,on: :member
    match '*unmatched', to: 'application#route_not_found', via: :all
end
get 'home/profile'
  root "home#index"

  match '*unmatched', to: 'application#route_not_found', via: :all
end

