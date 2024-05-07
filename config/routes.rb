Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")


  root "welcome#index"
  get '/register', to: 'users#new', as: 'register_user'

  resources :users, only: [:show, :create] do
  end

  get "/users/:id/discover", to: "movies#discover"
  get "/users/:id/movies", to: "movies#movies"
  get "/users/:id/movies/:movie_id", to: "movies#show"
end
