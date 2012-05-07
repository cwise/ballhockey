class AddCurrentStateToGamePlayers < ActiveRecord::Migration
  def self.up
    add_column :game_players, :current_state, :string
  end

  def self.down
    remove_column :game_players, :current_state
  end
end
