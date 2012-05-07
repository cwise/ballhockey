class MigrateGamePlayerStatus < ActiveRecord::Migration
  def self.up
    execute "UPDATE game_players SET current_state = 'no_response' WHERE player_status_id = 1"
    execute "UPDATE game_players SET current_state = 'out' WHERE player_status_id = 2"
    execute "UPDATE game_players SET current_state = 'in' WHERE player_status_id = 3"
    execute "UPDATE game_players SET current_state = 'late' WHERE player_status_id = 5"        
  end

  def self.down
    # do nothing
  end
end
