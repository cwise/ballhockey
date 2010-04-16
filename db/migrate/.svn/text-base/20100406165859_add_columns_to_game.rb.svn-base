class AddColumnsToGame < ActiveRecord::Migration
  def self.up
    add_column :games, :organizer, :string, {:limit => 256}
    add_column :games, :organizer_address, :string, {:limit => 256}
  end

  def self.down
  end
end
