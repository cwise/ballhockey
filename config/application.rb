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
    
    
    config.action_mailer.default_url_options = { :host => ENV['DEFAULT_HOST'] }
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      :tls                  => true,
      :address              => ENV['MAIL_HOST'],
      :port                 => ENV['MAIL_PORT'],
      :user_name            => ENV['MAIL_USER'],
      :password             => ENV['MAIL_PASSWORD'],
      :authentication       => ENV['MAIL_AUTH'],
      :domain               => ENV['MAIL_DOMAIN'],
      :enable_starttls_auto => true
    }    
    
  end
end
