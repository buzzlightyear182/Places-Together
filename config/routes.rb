Rails.application.routes.draw do
  devise_for :users
  # devise_for :users, :controllers => {:registrations => "registrations"}
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

root 'home#welcome'

resources :places, only: [:index] do
  resources :trips, only: [:index]
end

resources :activities, only: [:index] do
  resources :trips, only: [:index]
end

resources :trips, only: [:new, :create, :edit, :update, :destroy]

resources :trips, only: [:show] do
  resources :participations, only: [:create]
end

resources :profiles, only: [:edit, :update, :show] do resources :reviews, only: [:index, :new, :create, :edit, :update, :destroy]
end

get '/places/:place_id/trips/calendar' => 'trips#calendar'
get '/activities/:activity_id/trips/calendar' => 'trips#calendar'

post 'search' => 'search#create'

get 'confirm_joiner/:id' => 'participations#add_joiner'


  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
