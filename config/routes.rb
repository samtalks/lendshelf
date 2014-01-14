Lendshelf::Application.routes.draw do
  get "sessions/create"
  get "sessions/destroy"
  resources :users do
    resources :items, except: [:index]
  end

  
  resources :groups
  root 'users#splash'
  

  get 'items/search' => 'items#search_results', as: :search_item

  post 'user/:id/requests/:item_id' => 'users#request_loan', as: :request_loan
  post 'user/:id/approves/:item_id' => 'users#approve_loan', as: :approve_loan
  post 'user/:id/denies/:item_id' => 'users#deny_loan', as: :deny_loan
  post 'user/:id/returns/:item_id' => 'users#return_loan', as: :return_loan

  post 'group/:id/join_group/:user_id' => 'groups#join_group', as: :join_group
  post 'group/:id/leave_group/:user_id' => 'groups#leave_group', as: :leave_group

  post 'group/:id/approve_member/:user_id' => 'groups#approve_member', as: :approve_member
  post 'group/:id/deny_member/:user_id' => 'groups#deny_member', as: :deny_member


  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
