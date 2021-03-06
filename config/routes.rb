Rails.application.routes.draw do

  get 'faq', to: 'home#faq'
  get 'contact', to: 'contacts#new', as: "contact"
  resources "contacts", only: [:new, :create]

  # devise_for :users
  #used with tracking login history
  devise_for :users, :controllers => { :registrations => "registrations", :sessions => "track_sessions" }

  resources :users

  resources :home
  resources :categories
  resources :budget_items
  # resources :transactions
  # root 'accounts#index'
  # root 'welcome#index'
  root 'home#index'

  resources :accounts do
    resources :transactions do
      resources :documents
    end
    #will be for transfers controller when refactoring is done for transfers
    #resources :transfers, only: %i[show post]    
  end

  get 'list_accounts', to: 'accounts#list'
  get 'options', to: 'accounts#options'
  get 'financial_summary', to: 'accounts#financial_summary'
  get 'budget_show_all', to: 'budget_items#show_all'
  # resources :checkings, controller: :accounts

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
