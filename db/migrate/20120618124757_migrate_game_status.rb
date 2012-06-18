class MigrateGameStatus < ActiveRecord::Migration
  def self.up
    execute "UPDATE games SET current_state = 'not_called' WHERE game_status_id = 1"
    execute "UPDATE games SET current_state = 'game_on' WHERE game_status_id = 2"
    execute "UPDATE games SET current_state = 'cancelled' WHERE game_status_id = 3"
    execute "UPDATE games SET current_state = 'send_update' WHERE game_status_id = 5"        
  end

  def self.down
    # do nothing
  end
end
