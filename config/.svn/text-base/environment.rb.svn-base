# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.2' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')
require "action_mailer"

Rails::Initializer.run do |config|
  config.time_zone = 'UTC'

  config.action_mailer.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    :address => "smtp.broadband.rogers.com",
    :port => 25,
    :user_name => "chriswise@rogers.com",
    :password => "cat2dogs",
    :authentication => :login
  }
end

require "will_paginate"