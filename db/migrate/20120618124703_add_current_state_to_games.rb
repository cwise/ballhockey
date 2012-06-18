class AddCurrentStateToGames < ActiveRecord::Migration
  def change
    add_column :games, :current_state, :string
  end
end
