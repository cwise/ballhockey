unless GameStatus.exists?
  GameStatus.create(:description => 'Not called')
  GameStatus.create(:description => 'Game On!')
  GameStatus.create(:description => 'Cancelled')
  GameStatus.create(:description => 'Send Update')
end

unless Equipment.exists?
  Equipment.create(:id => 1, :description => 'Bag and pinnies')
  Equipment.create(:id => 2, :description => 'Net (one)')
  Equipment.create(:id => 3, :description => 'Nets (both)')
  Equipment.create(:id => 4, :description => 'Fence')
  Equipment.create(:id => 5, :description => 'None')
end

unless PlayerStatus.exists?
  PlayerStatus.create(:description => 'No response')
  PlayerStatus.create(:description => 'Out')
  PlayerStatus.create(:description => 'In')
  PlayerStatus.create(:description => 'Maybe')
end
