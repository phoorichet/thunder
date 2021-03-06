Rails.application.routes.draw do
  # custom routes must be placed in the first order so that it override 
  # routes in resources.
  # 
  get  'insurances/masters'         => 'insurances#index_master', as: :masters_insurances
  get  'insurances/masters/new'     => 'insurances#new_master', as: :new_master_insurance
  post 'insurances/masters'         => 'insurances#create_master', as: :master_insurances
  get 'insurances/masters/:id'      => 'insurances#show_master', as: :master_insurance
  get 'insurances/masters/:id/edit' => 'insurances#edit_master', as: :edit_master_insurance
  put 'insurances/masters/:id'      => 'insurances#update_master'
  patch 'insurances/masters/:id'    => 'insurances#update_master'
  delete 'insurances/masters/:id'   => 'insurances#destroy_master'

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

  get  'pas/masters'         => 'pas#index_master', as: :masters_pas
  get  'pas/masters/new'     => 'pas#new_master', as: :new_master_pa
  post 'pas/masters'         => 'pas#create_master', as: :master_pas
  get 'pas/masters/:id'      => 'pas#show_master', as: :master_pa
  get 'pas/masters/:id/edit' => 'pas#edit_master', as: :edit_master_pa
  put 'pas/masters/:id'      => 'pas#update_master'
  patch 'pas/masters/:id'    => 'pas#update_master'
  delete 'pas/masters/:id'   => 'pas#destroy_master'

  get 'pa_coverages/masters'          => 'pa_coverages#index_master', as: :masters_pa_coverages
  get 'pa_coverages/masters/new'      => 'pa_coverages#new_master', as: :new_master_pa_coverage
  post 'pa_coverages/masters'         => 'pa_coverages#create_master', as: :master_pa_coverages
  get 'pa_coverages/masters/:id'      => 'pa_coverages#show_master', as: :master_pa_coverage
  get 'pa_coverages/masters/:id/edit' => 'pa_coverages#edit_master', as: :edit_master_pa_coverage
  put 'pa_coverages/masters/:id'      => 'pa_coverages#update_master'
  patch 'pa_coverages/masters/:id'    => 'pa_coverages#update_master'
  delete 'pa_coverages/masters/:id'   => 'pa_coverages#destroy_master'

  get 'coverages/search' => 'coverages#search'
  get 'riders/search' => 'riders#search'
  get 'insurances/search' => 'insurances#search'
  get 'pas/search' => 'pas#search'
  get 'pa_coverages/search' => 'pa_coverages#search'

  # end custom routes

  resources :persons do
    resources :books
    
    member do 
      get 'new_relation'
      post 'create_relation'
      delete 'delete_relation'

      # Aggegration views
      get 'summary'
      get 'all_books'
      get 'tax'
      get 'show_book'
    end
    collection do
      get 'search'
    end
  end

  resources :books do 
    resources :insurances do
      collection do
        get  'new_from_master'
        post 'create_from_master'
        get 'new_main'
      end
    end
    resources :riders
    resources :pas
  end

  resources :insurances do 
    resources :dividends
    resources :returns
    resources :protections
    resources :surrenders
  end

  resources :riders do
    resources :coverages
  end

  resources :pas do
    resources :pa_coverages
  end


  devise_for :users

  resources :users do
    member do
      get 'new_company' => 'users#new_company', as: :new_company
      post 'company'    => 'users#create_company', as: :company
      delete 'company/:company_id'  => 'users#destroy_company', as: :delete_company
    end
  end
  resources :companies

  # API V1
  namespace :api, defaults: {:format=> 'json'} do
    namespace :v1 do

      mount_devise_token_auth_for 'User', at: 'auth'

      get  'insurances/masters'         => 'insurances#index_master', as: :masters_insurances
      get  'insurances/masters/new'     => 'insurances#new_master', as: :new_master_insurance
      post 'insurances/masters'         => 'insurances#create_master', as: :master_insurances
      get 'insurances/masters/:id'      => 'insurances#show_master', as: :master_insurance
      get 'insurances/masters/:id/edit' => 'insurances#edit_master', as: :edit_master_insurance
      put 'insurances/masters/:id'      => 'insurances#update_master'
      patch 'insurances/masters/:id'    => 'insurances#update_master'
      delete 'insurances/masters/:id'   => 'insurances#destroy_master'

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

      get  'pas/masters'         => 'pas#index_master', as: :masters_pas
      get  'pas/masters/new'     => 'pas#new_master', as: :new_master_pa
      post 'pas/masters'         => 'pas#create_master', as: :master_pas
      get 'pas/masters/:id'      => 'pas#show_master', as: :master_pa
      get 'pas/masters/:id/edit' => 'pas#edit_master', as: :edit_master_pa
      put 'pas/masters/:id'      => 'pas#update_master'
      patch 'pas/masters/:id'    => 'pas#update_master'
      delete 'pas/masters/:id'   => 'pas#destroy_master'

      get 'pa_coverages/masters'          => 'pa_coverages#index_master', as: :masters_pa_coverages
      get 'pa_coverages/masters/new'      => 'pa_coverages#new_master', as: :new_master_pa_coverage
      post 'pa_coverages/masters'         => 'pa_coverages#create_master', as: :master_pa_coverages
      get 'pa_coverages/masters/:id'      => 'pa_coverages#show_master', as: :master_pa_coverage
      get 'pa_coverages/masters/:id/edit' => 'pa_coverages#edit_master', as: :edit_master_pa_coverage
      put 'pa_coverages/masters/:id'      => 'pa_coverages#update_master'
      patch 'pa_coverages/masters/:id'    => 'pa_coverages#update_master'
      delete 'pa_coverages/masters/:id'   => 'pa_coverages#destroy_master'

      get 'coverages/search' => 'coverages#search'
      get 'riders/search' => 'riders#search'
      get 'insurances/search' => 'insurances#search'
      get 'pas/search' => 'pas#search'
      get 'pa_coverages/search' => 'pa_coverages#search'

      resources :persons do
        resources :books

        collection do
          get 'search'
        end
        member do 
          post 'set_parent'
        end
      end

      resources :books do 
        resources :riders 
        resources :insurances do
          collection do
            get  'new_from_master'
            post 'create_from_master'
          end
        end
      end

      resources :insurances do
		    resources :dividends
        resources :returns
        resources :protections
        resources :surrenders
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
