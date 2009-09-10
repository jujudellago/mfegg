ActionController::Routing::Routes.draw do |map|
  map.resources :galleries , :path_prefix=>":locale" do |gallery|
    gallery.resources :photos, :name_prefix => 'gallery_', :member=>{:editname=>:post,:editdesc=>:post,:default=>:get},:collection=>{:positions=>:get}
  end

  

                                              
                       
  
  map.home '/', :controller => 'pages', 
                 :action => 'show', 
                 :id => '1-welcome-page', :path_prefix=>":locale"

  map.resources :pages , :path_prefix=>":locale", :collection => { :test => :get,:positions=>:get,:update_positions=>:post}, :member => { :update_ajax => :post,:set_page_keywords=>:post}
  map.resources :my_images, :controller => 'images'
  map.open_id_complete 'session', :controller => "session", :action => "create", :requirements => { :method => :get }
  map.resource :session
  
  map.resources :users, :member => { :admin => :post } do |user|
    user.resources :moderators
  end
  
  map.resources :forums do |forum|
    forum.resources :topics, :name_prefix => nil do |topic|
      topic.resources :posts, :name_prefix => nil
      topic.resource :monitorship, :controller => :monitorships, :name_prefix => nil
    end
  end

  map.resources :posts, :name_prefix => 'all_', :collection => { :search => :get }

  %w(user forum).each do |attr|
    map.resources :posts, :name_prefix => "#{attr}_", :path_prefix => "/#{attr.pluralize}/:#{attr}_id"
  end

  map.signup   'signup',        :controller => 'users',   :action => 'new'
  map.settings 'settings',      :controller => 'users',   :action => 'edit'
  map.activate 'activate/:key', :controller => 'users',   :action => 'activate'
  map.login    'login',         :controller => 'session', :action => 'new'
  map.logout   'logout',        :controller => 'session', :action => 'destroy'
  map.with_options :controller => 'posts', :action => 'monitored' do |map|
    map.formatted_monitored_posts 'users/:user_id/monitored.:format'
    map.monitored_posts           'users/:user_id/monitored'
  end
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'


  map.exceptions 'logged_exceptions/:action/:id', :controller => 'logged_exceptions', :action => 'index', :id => nil
end
