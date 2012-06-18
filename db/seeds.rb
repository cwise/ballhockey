unless Equipment.exists?
  Equipment.create(:id => 1, :description => 'Bag and pinnies')
  Equipment.create(:id => 2, :description => 'Net (one)')
  Equipment.create(:id => 3, :description => 'Nets (both)')
  Equipment.create(:id => 4, :description => 'Fence')
  Equipment.create(:id => 5, :description => 'None')
end