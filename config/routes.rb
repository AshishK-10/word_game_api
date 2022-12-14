Rails.application.routes.draw do
  devise_for :users
  resources :keys
  get 'fortytwoword/word'
  get 'fortytwoword/:word/example',to: "fortytwoword#example"
  get 'fortytwoword/:word/defination',to: "fortytwoword#defination"
  get 'fortytwoword/:word/relation',to: "fortytwoword#wordRelation"
  get 'home/profile'
  root "home#index"
  match '*unmatched', to: 'application#route_not_found', via: :all
end

