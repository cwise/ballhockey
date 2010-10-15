# offsite backup daily
every 1.day, :at => '4:00 am' do
  rake "-s backup:run trigger='nrcanhockey-offsite'"
end

