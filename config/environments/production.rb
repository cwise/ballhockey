# Settings specified here will take precedence over those in config/environment.rb

# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = true

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true
config.action_view.cache_template_loading            = true

config.action_mailer.default_url_options = { :host => "nrcanhockey.murmurinfo.ca" }
config.action_mailer.delivery_method = :sendmail
ActionMailer::Base.smtp_settings = {
  :address => "smtp.gmail.com",
  :port => 587,
  :user_name => "mailer@murmurinformatics.com",
  :password => "n3v3rspam",
  :authentication => :login
}

MAIL_SENDER="mailer@murmurinformatics.com"