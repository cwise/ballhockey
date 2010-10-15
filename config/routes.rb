ActionController::Routing::Routes.draw do |map|    
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
  map.resources :sessions
  map.login 'login', :controller => 'sessions', :action => 'new'
  map.logout 'logout', :controller => 'sessions', :action => 'destroy'
    
  map.connect '/current', :controller => 'game', :action => 'current'
  map.root :controller => 'global', :action => 'index'
  map.connect '', :controller => 'global', :action => 'index'
end


