Rails.application.routes.draw do
  post '/votes/:vote_type/:item_type/:item_id/:short', to: "votes#create", as: "votes"
  delete '/votes/:vote_type/:item_type/:item_id/:short', to: "votes#destroy", as: "vote"
  
  resources :invitations
  get "/accept-invitation/:id/:password_token", to: "invitations#accept", as: "accept_invitation"
  get "/decline-invitation/:id/:password_token", to: "invitations#decline", as: "decline_invitation"
  resources :viewers

  get '/search', to: 'searches#index', as: 'search'
  
  resources :activities
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    resources :actualities
    resources :call_for_ideas
    resources :comments
      resources :avatar, only: %i[new create destroy]

    resources :ideas
    patch "/allow_idea/:id", to: "ideas#admin_update", as: "admin_idea"
    get "/share-an-idea", to: "ideas#new"
    post "/share-an-idea", to: "ideas#create"
    resources :options
    resources :questions
    resources :surveys
    post "/surveys/:id", to: "surveys#answer"
    ###### pages #####
    get "/my-space", to: "spaces#index"
    get "/:name/about", to: "spaces#show", as: "about"
    ##################
    get "/my-profile", to: "users#show", as: "my_profile"
    get "/edit-my-profile", to: "users#edit"
    patch "/edit-my-profile", to: "users#update"

    resources :spaces, excpect: %i[new destroy]
    patch "/join_space/:id/:user_id", to: "spaces#join", as: "join_space"
    get "/visit-space", to: "spaces#index", as: "visit_space"
    get "/edit-my-space", to: "spaces#edit"
    patch "/edit-my-space", to: "spaces#update"
    get "/create-a-survey", to: "surveys#new"
    post "/create-a-survey", to: "surveys#create"
    resources :projects
    get "/create-a-project", to: "projects#new"
    post "/create-a-project", to: "projects#create"
    get "/share-an-actuality", to: "actualities#new"
    post "/share-an-actuality", to: "actualities#create"

    root to: "pages#home"
    resources :users, only: %i[index]
    get '/users/show/:id', to: 'users#show',  as: 'user' 
    delete '/kick-out/:id', to: "users#kick_out", as: "kick_out"
    devise_for :users, skip: :omniauth_callbacks, controllers: {
    	sessions: "users/sessions",
      registrations: "users/registrations",
      confirmations: "users/confirmations",
      unlocks: "users/unlocks",
      passwords: "users/passwords"
    }
  end
  devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  mount ActionCable.server => "/cable"
  mount RailsAdmin::Engine => '/rails_admin', as: 'rails_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
