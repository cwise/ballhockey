Nrcanhockey::Application.configure do

  # Settings specified here will take precedence over those in config/environment.rb

  # The production environment is meant for finished, "live" apps.
  # Code is not reloaded between requests
  config.cache_classes = true

  # Specifies the header that your server uses for sending files
  config.action_dispatch.x_sendfile_header = "X-Sendfile"
  
  config.action_mailer.default_url_options = { :host => "nrcanhockey.murmurinfo.ca" }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :tls => true,
    :address => "smtp.gmail.com",
    :port => 587,
    :user_name => "mailer@murmurinformatics.com",
    :password => "mailer!!",
    :authentication => :plain,
    :domain => 'murmurinfo.ca',
    :enable_starttls_auto => true
  }

  MAIL_SENDER="mailer@murmurinformatics.com"
end