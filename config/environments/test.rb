BallHockey::Application.configure do

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
  
  config.serve_static_assets = true
  config.static_cache_control = "public, max-age=3600"
  config.assets.allow_debugging = true  
end