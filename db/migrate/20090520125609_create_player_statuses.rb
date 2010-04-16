class CreatePlayerStatuses < ActiveRecord::Migration
  def self.up
    create_table :player_statuses do |t|
      t.string :description
      t.timestamps
    end
  end

  def self.down
    drop_table :player_statuses
  end
end
