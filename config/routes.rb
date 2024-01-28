Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  Rails.application.routes.draw do
  namespace :v1 do
    resources :customers, only: [:show]
    resources :orders, only: [:create]
    end
  end

end
