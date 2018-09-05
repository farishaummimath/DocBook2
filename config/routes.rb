ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.
   map.resources :users, :only => [:index, :show_pdf] , :collection => { :show_pdf => :get }
   map.resources :departments
   map.resources :doctors, :only => [:index,:new,:edit,:create,:update,:show, :destroy]
   
   map.resources :patients
   map.resources :rooms, :only => [:index,:new,:room_dashboard,:edit,:create,:update,:show, :destroy,:all_rooms,:export], :collection => {:room_dashboard => [:get]}
   map.resources :beds
   map.resources :time_slots,:only => [:new, :create, :destroy]
   map.resources :appointments,
     :only => [:index,:new,:edit,:create,:update,:show, :destroy, :update_doctors,:update_slots], 
     :collection => {:my_patients => [:get], :my_appointments =>[:get],:update_doctors => [:get, :post],:update_slots => [:get, :post]}
  
   map.resources :bedallocations, :collection => {:update_beds => [:get, :post]}
   
   map.resources :sessions, :only => [:new, :create, :destroy]
   map.mypatients '/mypatients', :controller => 'appointments', :action => "my_patients"

   map.room_details '/room_details', :controller => 'rooms', :action => "all_rooms"
   map.room_export '/room_export', :controller => 'rooms', :action => 'export'
   map.resources :bedallocations
   map.resources :medical_records, :collection => {:all_medical_records => [:get],:my_medical_records=> [:get],:show_patient_record => [:get],:medical_record_pdf => [:get],:my_medical_record_pdf => [:get]}
     
   map.allmedicalrecords '/allmedicalrecords', :controller => 'medical_records', :action => 'all_medical_records'
   
   map.signin  '/signin',   :controller => 'sessions', :action => 'new'
   map.signout  '/signout', :controller => 'sessions', :action => 'destroy'
   map.contact '/contact', :controller => 'pages', :action => "contact"
   map.about '/about', :controller => 'pages', :action => "about"   
   map.resources :patients do |patient|
      patient.resources :medical_records
   end
  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
   map.root :controller => "pages", :action => "home"


  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
