class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.date :game_date
      t.text :message
      t.integer :game_status_id

      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
