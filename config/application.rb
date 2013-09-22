require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require *Rails.groups(:assets => %w(development test))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module BallHockey
  class Application < Rails::Application
    config.time_zone = 'Eastern Time (US & Canada)'
    config.encoding = "utf-8"
    config.filter_parameters += [:password]    
    config.autoload_paths += %W(#{Rails.root}/lib)
    config.assets.enabled = true
    config.assets.version = '1.0'
    
    config.assets.precompile += ["fontawesome-webfont.ttf",
                             "fontawesome-webfont.eot",
                             "fontawesome-webfont.svg",
                             "fontawesome-webfont.woff"]            
  end
end
