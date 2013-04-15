class AddDefaultToDeliveryState < ActiveRecord::Migration
  def change
    change_column :game_players, :delivery_state, :string, :default => 'sent'
  end
end
