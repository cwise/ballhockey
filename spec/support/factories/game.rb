Factory.define :game do |f|
  f.sequence(:game_date) { |n| n.days.from_now }
  f.organizer "Chris Wise"
  f.organizer_address "chriswise71@gmail.com"
  f.message "My message of hope!"
end