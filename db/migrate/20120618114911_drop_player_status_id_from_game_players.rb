class DropPlayerStatusIdFromGamePlayers < ActiveRecord::Migration
  def up
    remove_column :game_players, :player_status_id
  end

  def down
    add_column :game_players, :player_status_id, :integer
  end
end
