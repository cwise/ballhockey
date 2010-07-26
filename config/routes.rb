ActionController::Routing::Routes.draw do |map|
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.connect '/current', :controller => 'game', :action => 'current'
  map.connect '', :controller => 'global', :action => 'index'
end
