Rails.application.routes.draw do

#  devise_for :admins

  devise_for :admin, controllers: {
  passwords: 'admin/passwords',
  registrations: 'admin/registrations',
  sessions: 'admin/sessions'
 }

  root 'public/homes#top'
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
 }

  namespace :admin do
    root :to => 'homes#top'
    #patch '/genres' => 'genres#update'
    resources :items
    resources :genres,only:[:index,:edit,:create,:update]
    resources :customers
    resources :orders,only:[:index,:show,:update]
    resources :order_details, only:[:update]
  end
  namespace :public do
    get '/customers/my_page' => 'customers#show'
    get '/about' => 'homes#about'
    get '/customers/unsubcribe' => 'customers#unsubcribe'
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :items, only:[:index,:show,:new] do
    get :search, on: :collection
    patch '/update' => 'customers#update'
    end

    root 'items#top'
    resources :items, only: [:show, :index]
    get 'about' => 'items#about'
    resources :cart_items
    post '/orders/confirm' => 'orders#confirm'
    get '/orders/complete' => 'orders#complete'
    patch '/customers/withdrawal' => 'customers#withdrawal'
    resources :orders, only:[:new,:create,:index,:show]
    resource :customers, only:[:edit,:update]
    resources :addresses, only:[:index, :edit, :destroy, :create, :update]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
