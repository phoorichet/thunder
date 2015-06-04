Rails.application.routes.draw do
  # custom routes must be placed in the first order so that it override 
  # routes in resources.
  # 
  get  'plans/masters'         => 'plans#index_master', as: :masters_plans
  get  'plans/masters/new'     => 'plans#new_master', as: :new_master_plan
  post 'plans/masters'         => 'plans#create_master', as: :master_plans
  get 'plans/masters/:id'      => 'plans#show_master', as: :master_plan
  get 'plans/masters/:id/edit' => 'plans#edit_master', as: :edit_master_plan
  put 'plans/masters/:id'      => 'plans#update_master'
  patch 'plans/masters/:id'    => 'plans#update_master'
  delete 'plans/masters/:id'   => 'plans#destroy_master'

  get  'riders/masters'         => 'riders#index_master', as: :masters_riders
  get  'riders/masters/new'     => 'riders#new_master', as: :new_master_rider
  post 'riders/masters'         => 'riders#create_master', as: :master_riders
  get 'riders/masters/:id'      => 'riders#show_master', as: :master_rider
  get 'riders/masters/:id/edit' => 'riders#edit_master', as: :edit_master_rider
  put 'riders/masters/:id'      => 'riders#update_master'
  patch 'riders/masters/:id'    => 'riders#update_master'
  delete 'riders/masters/:id'   => 'riders#destroy_master'

  get 'coverages/masters'          => 'coverages#index_master', as: :masters_coverages
  get 'coverages/masters/new'      => 'coverages#new_master', as: :new_master_coverage
  post 'coverages/masters'         => 'coverages#create_master', as: :master_coverages
  get 'coverages/masters/:id'      => 'coverages#show_master', as: :master_coverage
  get 'coverages/masters/:id/edit' => 'coverages#edit_master', as: :edit_master_coverage
  put 'coverages/masters/:id'      => 'coverages#update_master'
  patch 'coverages/masters/:id'    => 'coverages#update_master'
  delete 'coverages/masters/:id'   => 'coverages#destroy_master'

  get 'coverages/search' => 'coverages#search'
  get 'riders/search' => 'riders#search'
  get 'plans/search' => 'plans#search'

  # end custom routes

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

  resources :plans do
    resources :riders
  end

  resources :riders do
    resources :coverages
  end


  devise_for :users

  # API V1
  namespace :api, defaults: {:format=> 'json'} do
    namespace :v1 do

      mount_devise_token_auth_for 'User', at: 'auth'

      get  'plans/masters'         => 'plans#index_master', as: :masters_plans
      get  'plans/masters/new'     => 'plans#new_master', as: :new_master_plan
      post 'plans/masters'         => 'plans#create_master', as: :master_plans
      get 'plans/masters/:id'      => 'plans#show_master', as: :master_plan
      get 'plans/masters/:id/edit' => 'plans#edit_master', as: :edit_master_plan
      put 'plans/masters/:id'      => 'plans#update_master'
      patch 'plans/masters/:id'    => 'plans#update_master'
      delete 'plans/masters/:id'   => 'plans#destroy_master'

      get  'riders/masters'         => 'riders#index_master', as: :masters_riders
      get  'riders/masters/new'     => 'riders#new_master', as: :new_master_rider
      post 'riders/masters'         => 'riders#create_master', as: :master_riders
      get 'riders/masters/:id'      => 'riders#show_master', as: :master_rider
      get 'riders/masters/:id/edit' => 'riders#edit_master', as: :edit_master_rider
      put 'riders/masters/:id'      => 'riders#update_master'
      patch 'riders/masters/:id'    => 'riders#update_master'
      delete 'riders/masters/:id'   => 'riders#destroy_master'

      get 'coverages/masters'          => 'coverages#index_master', as: :masters_coverages
      get 'coverages/masters/new'      => 'coverages#new_master', as: :new_master_coverage
      post 'coverages/masters'         => 'coverages#create_master', as: :master_coverages
      get 'coverages/masters/:id'      => 'coverages#show_master', as: :master_coverage
      get 'coverages/masters/:id/edit' => 'coverages#edit_master', as: :edit_master_coverage
      put 'coverages/masters/:id'      => 'coverages#update_master'
      patch 'coverages/masters/:id'    => 'coverages#update_master'
      delete 'coverages/masters/:id'   => 'coverages#destroy_master'

      get 'coverages/search' => 'coverages#search'
      get 'riders/search' => 'riders#search'
      get 'plans/search' => 'plans#search'

      resources :insured_users do
        resources :books
        
        collection do
          get 'search'
        end
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

      resources :plans do
        resources :riders
      end

      resources :riders do
        resources :coverages
      end
      
    end
  end

  
  # resources :users
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
