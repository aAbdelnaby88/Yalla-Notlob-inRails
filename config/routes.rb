Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
resources:users
  get '/', to: 'users#index'
  get '/signup', to: 'users#signup'
  post '/signup_form', to: 'users#signup_form'
  get '/signin', to: 'users#signin'
  post '/signin_form', to: 'users#signin_form'
  post '/logout', to: 'users#log_out'
  get '/groups', to: 'users#groups'
  post '/groups', to: 'users#new_group'
  delete '/groups/:id', to: 'users#delete_group',as: :delete_group
  delete '/groups/:id/users/:user_id', to: 'users#delete_group_user',as: :delete_group_user
  post '/groups/:id/users/:user_name', to: 'users#add_group_user',as: :add_group_user
  get '/friends', to: 'users#friends'
  post '/friends/:friend_email', to: 'users#addnewFriend'
  delete '/friends/:friend_id', to: 'users#deleteFriend' ,as: :delete_friend
  get '/orders/new', to: 'orders#addorder'
  get '/order', to: 'orders#order'
  get '/orders/:id', to: 'orders#show_order'
  post '/orders/:id/items', to: 'orders#create_item'
  delete '/orders/:id/items/:item_id', to: 'orders#delete_item',as: :delete_item

end

  
