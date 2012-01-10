ActiveAdmin.register Player, {:sort_order => :name} do
  filter :name
  filter :email_address
  
  index do  
    column :name
    column :email_address
    column :active
    column :times_played
    column :last_played
    column :times_played_goalie
    column :last_played_goalie
    column :goalie_factor
    default_actions  
  end
end