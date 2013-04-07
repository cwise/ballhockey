class AddDeliveryStateToGamePlayers < ActiveRecord::Migration
  def change
    add_column :game_players, :delivery_state, :string
  end
end
