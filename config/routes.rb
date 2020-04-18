Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources:users
  get '/', to: 'users#index'
  get '/signup', to: 'users#signup'
  post '/signup', to: 'users#signup_form'
  get '/signin', to: 'users#signin'
  post '/signin', to: 'users#signin_form'
  get '/groups', to: 'users#groups'
end
