set :application, "nrcanhockey"
set :repository,  "http://smyth100.local:8800/svn/#{application}"

set :deploy_to,    "/Library/WebServer/#{application}"
set :deploy_via,   :export

set :scm_username, "cwise"
set :scm_password, "upandatom"

# needed to add this as subversion is in a weird location
set :svn, "/opt/subversion/bin/svn"

ssh_options[:forward_agent] = true

role :app, "nrcanhockey.murmurinfo.ca"
role :web, "nrcanhockey.murmurinfo.ca"
role :db,  "nrcanhockey.murmurinfo.ca", :primary => true

set :mongrel_cmd, "/usr/bin/mongrel_rails_persist"
set :mongrel_ports, 3030..3030

set :user,  "cwise"
set :group, "admin"

namespace :deploy do
  desc "Start Mongrels processes and add them to launchd."
  task :start, :roles => :app do
    mongrel_ports.each do |port|
      sudo "#{mongrel_cmd} start -p #{port} -e production \
            --user #{user} --group #{group} -c #{current_path}"
    end
  end

  desc "Stop Mongrels processes and remove them from launchd."
  task :stop, :roles => :app do
    mongrel_ports.each do |port|
      sudo "#{mongrel_cmd} stop -p #{port}"
    end
  end

  desc "Restart Mongrel processes"
  task :restart, :roles => :app do
    stop
    start
  end

end