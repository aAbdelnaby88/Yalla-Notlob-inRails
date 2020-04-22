Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
resources:users
  get '/', to: 'users#index'
  get '/signup', to: 'users#signup'
  get '/signup_form', to: 'users#signup_form'
  get '/signin', to: 'users#signin'
  get '/signin_form', to: 'users#signin_form'
  get '/groups', to: 'users#groups'
  post '/groups', to: 'users#new_group'
  delete '/groups/:id', to: 'users#delete_group',as: :delete_group
  delete '/groups/:id/users/:user_id', to: 'users#delete_group_user',as: :delete_group_user
  post '/groups/:id/users/:user_name', to: 'users#add_group_user',as: :add_group_user
  get '/friends', to: 'users#friends'
  post '/friends/:friend_email', to: 'users#addnewFriend'
  delete '/friends/:friend_id', to: 'users#deleteFriend' ,as: :delete_friend
  
  get '/orders/new', to: 'orders#addorder'
  post '/orders/new', to: 'orders#addNewOrder',as: :add_order_path
  get '/orders', to: 'orders#order'
  get '/orderdetails', to: 'orders#orderdetails'
  post '/is-friend', to: "users#is_friend"
end

  
