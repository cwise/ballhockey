class AddColumnsToPlayers < ActiveRecord::Migration
  def self.up
    add_column :players, :active, :boolean, :default => true
  end

  def self.down
  end
end
