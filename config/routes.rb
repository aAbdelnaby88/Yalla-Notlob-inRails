Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources:users
  get '/signin', to: 'users#signin'
  get '/signup', to: 'users#signup'
  get '/groups', to: 'users#groups'
end
