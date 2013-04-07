unless $heroku_deploying
	uri = URI.parse(ENV["REDISTOGO_URL"])
	Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password) 
else
  puts "Skipping Resque configuration due to Heroku precompilation"
end