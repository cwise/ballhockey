class DropOldViews < ActiveRecord::Migration
  def self.up
    drop_table :played_games
    drop_table :game_goalies
  end

  def self.down
    # no going back
  end
end
