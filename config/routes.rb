Rails.application.routes.draw do

#  devise_for :admins
  devise_for :admin, controllers: {

  sessions: 'admin/sessions'
 }
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
  get '/customers/my_page' => 'public/customers#show'
  namespace :public do
    get '/about' => 'homes#about'
    get '/customers/unsubcribe' => 'customers/unsubcribe#unsubcribe'
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :items, only:[:index,:show,:new] do
    get :search, on: :collection

  end

    scope module: 'customers' do
    root 'items#top'
    resources :items, only: [:show, :index]
    get 'about' => 'items#about'
   end
    resources :cart_items
    post '/orders/session' => 'orders#session_create'
    get '/orders/confirm' => 'orders#confirm'
    post '/orders/confirm' => 'orders#confirm'
    get '/orders/thanks' => 'orders#thanks'
    patch '/customers/withdrawal' => 'customers#destroy'
    get '/customers/withdrawal' => 'customers#withdrawal'
    resources :orders, only:[:new,:create,:index,:show]
    resource :customers, only:[:edit,:update]
    resources :addresses, only:[:index, :edit, :destroy, :create, :update]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
