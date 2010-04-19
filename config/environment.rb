RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')
require "action_mailer"

Rails::Initializer.run do |config|
  config.time_zone = 'UTC'

  config.action_mailer.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    :address => "smtp.google.com",
    :port => 25,
    :user_name => "mailer@murmurinformatics.com",
    :password => "n3v3rspam",
    :authentication => :login
  }
end

require "will_paginate"