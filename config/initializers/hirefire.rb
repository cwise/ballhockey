HireFire::Resource.configure do |config|
  config.dyno(:all_worker) do
    HireFire::Macro::Resque.queue
  end
end