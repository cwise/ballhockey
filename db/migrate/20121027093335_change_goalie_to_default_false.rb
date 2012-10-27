class ChangeGoalieToDefaultFalse < ActiveRecord::Migration
  def up
    change_column :game_players, :goalie, :boolean, {:default => false}
  end

  def down
  end
end
