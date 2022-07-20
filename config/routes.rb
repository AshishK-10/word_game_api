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
end
  root "home#index"
end
