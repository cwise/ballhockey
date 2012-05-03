Nrcanhockey::Application.configure do

  # Settings specified here will take precedence over those in config/environment.rb

  # The test environment is used exclusively to run your application's
  # test suite.  You never need to work with it otherwise.  Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs.  Don't rely on the data there!
  config.cache_classes = true

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Disable request forgery protection in test environment
  config.action_controller.allow_forgery_protection    = false

  config.active_support.deprecation = :stderr

  config.action_mailer.default_url_options = { :host => "localhost:3000" }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :tls => true,
    :address => "smtp.gmail.com",
    :port => 587,
    :user_name => "mailer@murmurinformatics.com",
    :password => "mailer!!",
    :authentication => :plain,
    :domain => 'localhost:3000',
    :enable_starttls_auto => true
  }

  MAIL_SENDER="mailer@murmurinformatics.com"
end