ActionMailer::Base.smtp_settings = {
  :address              => ENV['MAIL_HOST'],
  :port                 => ENV['MAIL_PORT'],
  :user_name            => ENV['MAIL_USER'],
  :password             => ENV['MAIL_PASSWORD'],
  :authentication       => ENV['MAIL_AUTH'],
  :domain               => ENV['MAIL_DOMAIN'],
  :enable_starttls_auto => true
}

#ActionMailer::Base.register_interceptor(SendGrid::MailInterceptor)

BallHockey::Application.configure do
  config.action_mailer.default_url_options = { :host => ENV['DEFAULT_HOST'] }

  config.before_initialize do                                                                                                                                                                                                       
    BallHockey::Application.routes.default_url_options[:host] = ENV['DEFAULT_HOST']
  end  
end