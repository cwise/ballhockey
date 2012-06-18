class DropUnusedTables < ActiveRecord::Migration
  def up
    drop_table :player_statuses
    drop_table :game_statuses
  end

  def down
    # no going back
  end
end
