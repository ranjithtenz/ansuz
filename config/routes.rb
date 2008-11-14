ActionController::Routing::Routes.draw do |map|
  map.from_plugin :ansuz_photo_album
  map.from_plugin :ansuz_blog
  map.from_plugin :savage_beast
  map.from_plugin :ansuz_content_section
  map.from_plugin :ansuz_user_manager
  map.from_plugin :ansuz_menu_system
  map.from_plugin :ansuz_theme_repository
  map.from_plugin :ansuz_theme_installer
  map.from_plugin :ansuz_scrollable_content
  map.from_plugin :ansuz_testimonials

  map.resources :users
  map.resources :tags
  map.namespace :admin do |admin|
    admin.resources :pages, :member => [:shift_order], :has_one => [:page_metadata]
    admin.resources :page_plugins
    admin.resources :plugins
    admin.resource  :account
    admin.connect 'account/:action/:id', :controller => 'account'
    admin.resource  :site_settings, :collection => [:fetch_theme_preview, :choose_theme]
    admin.resources :tags
  end
  map.connect '/admin', :controller => 'admin/pages'

  # stock rails routes
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

  # Ansuz route
  map.connect '/pages/*path', :controller => 'page', :action => 'indexer'
  map.connect '', :controller => 'page', :action => 'indexer', :path => ''
end
