BallHockey::Application.configure do
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