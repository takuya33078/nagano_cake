Rails.application.routes.draw do

  devise_for :admins
  root 'public/homes#top'
  devise_for :customers, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
 }

  namespace :admin do
    get '/admins' => 'admins#top'
    resources :items
    resources :genres
    resources :costomers
    resources :orders,only:[:index,:show,:update]
    resources :order_items, only:[:update]
  end
  namespace :public do
    get '/about' => 'homes#about'
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :items, only:[:index,:show,:new] do
    get :search, on: :collection
  end
    resources :cart_items
    post '/orders/session' => 'orders#session_create'
    get '/orders/confirm' => 'orders#confirm'
    post '/orders/confirm' => 'orders#confirm'
    get '/orders/thanks' => 'orders#thanks'
    patch '/customers/withdrawal' => 'customers#destroy'
    get '/costomers/withdrawal' => 'costomers#withdrawal'
    resources :orders, only:[:new,:create,:index,:show]
    resource :costomers, only:[:show ,:edit,:update]
    resources :addresses, only:[:index, :edit, :destroy, :create, :update]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
