Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # get '/users', to: 'users#index'
  # get '/users/:id', to: 'users#create'

  resources :users do
    resources :tweets
  end

  post 'users/:user_id/tweets/:id/like', to: 'tweets#like'
  post '/login', to: 'users#login'
end