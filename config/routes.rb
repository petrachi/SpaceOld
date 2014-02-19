#module ActionDispatch::Routing::Mapper::Base
#  def conditionnal_match path, conditions, rest
#    
#    conditions.each do |action, constraint|
#      match path => action, as: rest[:as], constraints: constraint
#    end
#  end
#end



Space::Application.routes.draw do

  scope module: :blog, constraints: {subdomain: "blog"} do
    match "/install" => "user#install", as: "install"
  
    controller "article" do
      match "/articles(/p/:pool)(/s/:serie)" => :index, as: :blog_articles
      match "/article/:tag" => :show, as: :blog_article
    
      # to delete
      match "/article/tmp(/:page)" => :tmp
    end
  
    controller "experience" do
      match "/experiences(/p/:pool)" => :index, as: :blog_experiences
      match "/experience/:tag" => :show, as: :blog_experience
      
      # to delete
      match "/experience/tmp(/:page)" => :tmp
    end
  
    controller "ressource" do
      
      
      
      # dsl extend
#      conditionnal_match "/ressources(/p/:pool)", {
#        index: ->(request){ request.path_parameters[:pool].blank? },
#        pool: ->(request){ request.path_parameters[:pool].present? }
#      }, as: :blog_ressources #, constraints: 
      
    # manually  
    #  match "/ressources(/p/:pool)" => :index, as: :blog_ressources, constraints: ->(request){ request.path_parameters[:pool].blank? }
    #  match "/ressources(/p/:pool)" => :pool, as: :blog_ressources, constraints: ->(request){ request.path_parameters[:pool].present? }
      
      
      
      
      match "/ressources(/p/:pool)" => :index, as: :blog_ressources
      match "/ressource/:tag" => :show, as: :blog_ressource
    end
    
    controller "screencast" do
      match "/screencasts(/p/:pool)(/s/:serie)(/page-:page)" => :index, as: :blog_screencasts
      match "/screencast/:tag" => :show, as: :blog_screencast
    end
    
    controller "snippet" do
      match "/snippet/:id" => :show, as: :blog_snippet
    end
  
    root to: "home#index"
  end
  match "/space_blog" => "space#blog", as: :space_blog
  
  
  match "/:controller(/:action(/:id))"  
  root to: "space#index"
  
  
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
