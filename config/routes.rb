Rails.application.routes.draw do



  resources :insured_users do
    resources :books
    
    member do 
      post 'set_parent'
    end
  end

  resources :books do 
    resources :plans do
      collection do
        get  'new_from_master'
        post 'create_from_master'
      end
    end
  end
  # resources :master_riders do 
  #   # end

  resources :plans do
    resources :riders do 
        collection do
          get  'new_from_master'
          post 'create_from_master'
        end
    end

    collection do
      get  'masters' => 'plans#index_master'
      get  'new_master'
      post 'master' => 'plans#create_master'
    end
    member do
      get 'master' => 'plans#show_master'
      put 'master' => 'plans#update_master'
      get 'edit_master'
      delete 'master' => 'plans#destroy_master'
    end
  end

  resources :riders do
    resources :coverages

    collection do
      get  'masters' => 'riders#index_master'
      get  'new_master'
      post 'master' => 'riders#create_master'
    end
    member do
      get 'master' => 'riders#show_master'
      put 'master' => 'riders#update_master'
      get 'edit_master'
      delete 'master' => 'riders#destroy_master'
    end
  end

  # Custom routes for coverages
  get 'coverages/masters' => 'coverages#index_master', as: :masters_coverages
  get 'coverages/new_master' => 'coverages#new_master', as: :new_master_coverage
  post 'coverages/master' => 'coverages#create_master', as: :master_coverages
  get 'coverages/:id/master' => 'coverages#show_master', as: :master_coverage
  get 'coverages/:id/edit_master' => 'coverages#edit_master', as: :edit_master_coverage
  put 'coverages/:id/master' => 'coverages#create_master'
  delete 'coverages/:id/master' => 'coverages#destroy_master'



  devise_for :users
  resources :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'static_pages#index'

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
