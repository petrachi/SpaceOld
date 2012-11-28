def controller_route application, controller
  match "/#{ controller }(/:action(/:id))", :controller => "#{ application }/#{ controller }", :as => controller
end

def application_routes application, controllers
  constraints :subdomain => application.to_s do
    controllers.each do |controller|
      controller_route application, controller  
    end
    
    match "/install", :controller => "#{ application }/user", :action=>"install", :as => "install"
    
    root :to => "#{ application }/home#index"
  end
  
  match "/space_#{ application }" => "space##{ application }", :as => "space_#{ application }"
end


Space::Application.routes.draw do
  match "/sign_up" => "main_user#sign_up", :as=>:sign_up
  match "/sign_up_errors" => "main_user#sign_up_errors"
  match "/sign_in" => "main_user#sign_in", :as=>:sign_in
  match "/sign_in_errors" => "main_user#sign_in_errors"
  match "/sign_out" => "main_user#sign_out", :as=>:sign_out
  
  application_routes :game, [:home, :user, :building, :technology, :squad, :profile]  
  application_routes :super_user, [:home, :user, :game]  
  
  
  match "/:controller(/:action(/:id))"
    
  root :to => "space#index"
  
  
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
