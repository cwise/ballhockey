class RemoveNoneFromEquipment < ActiveRecord::Migration
  def up
    e = Equipment.where(:description => 'None').first
    GamePlayer.where(:equipment_id => e.try(:id)).each{ |gp| gp.update_attribute(:equipment_id, nil) }
    e.destroy if e
  end

  def down
    # nothing to undo
  end
end
