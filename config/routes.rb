Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tutorials, only:[:show, :index]
      resources :videos, only:[:show]
    end
  end

  root 'welcome#index'
  get 'tags/:tag', to: 'welcome#index', as: :tag
  get '/register', to: 'users#new'

  namespace :admin do
    get "/dashboard", to: "dashboard#show"
    resources :tutorials, only: [:create, :edit, :update, :destroy, :new] do
      resources :videos, only: [:create]
    end
    resources :videos, only: [:edit, :update, :destroy]

    namespace :api do
      namespace :v1 do
        put "tutorial_sequencer/:tutorial_id", to: "tutorial_sequencer#update"
      end
    end
  end

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  get '/email_validation', to: "email_validation#create"
  get '/welcome_thanks', to: "email_validation#show"

  get '/invite', to: "invite#new"
  post '/invite', to: "invite#create"

  post '/new_friendship', to: 'follower#create'

  get '/dashboard', to: 'users#show'
  post '/dashboard', to: 'follower#create', as: 'create_follower'
  get '/about', to: 'about#show'
  get '/get_started', to: 'get_started#show'
  get '/auth/github', as: 'git_hub_login'
  get '/auth/github/callback', to: 'git_hub_sessions#create'
  # Is this being used?
  get '/video', to: 'video#show'

  resources :users, only: [:new, :create, :update, :edit]

  resources :tutorials, only: [:show, :index] do
    resources :videos, only: [:show, :index]
  end

  resources :user_videos, only:[:create, :destroy]
end
