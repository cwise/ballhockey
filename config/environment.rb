RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')
require "action_mailer"

Rails::Initializer.run do |config|
  config.time_zone = 'UTC'
  config.gem "will_paginate", :version => '2.3.14'
  config.gem "whenever"
  config.gem "backup"
end

require "will_paginate"
