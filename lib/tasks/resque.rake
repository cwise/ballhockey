require "resque/tasks"  
  
task "resque:setup" => :environment

Resque.after_fork do |job|
  ActiveRecord::Base.establish_connection
end