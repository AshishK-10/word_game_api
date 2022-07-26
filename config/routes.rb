Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :keys
  # Defines the root path route ("/")
  get 'fortytwoword/word'
  get 'fortytwoword/:word/example',to: "fortytwoword#example" 
  get 'fortytwoword/:word/defination',to: "fortytwoword#defination" 
  get 'fortytwoword/:word/relation',to: "fortytwoword#wordRelation" 
  match '*unmatched', to: 'application#route_not_found', via: :all
  
get 'home/profile'
  root "home#index"

  match '*unmatched', to: 'application#route_not_found', via: :all
end

