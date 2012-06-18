class DropGameStatusIdFromGames < ActiveRecord::Migration
  def up
    remove_column :games, :game_status_id
  end

  def down
    add_column :games, :game_status_id, :integer
  end
end
