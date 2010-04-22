class GamePlayer < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
  belongs_to :equipment
  belongs_to :player_status
  attr_accessor :email_address
  
  def name_with_status
    name=player.name
    if is_late? || is_maybe?
      name += " (" + player_status.description + ")"
    end

    if is_carrying_equipment?
      name += " (" + equipment.description + ")"
    end
    name
  end

  def is_late?
    player_status_id==5
  end

  def is_maybe?
    player_status_id==4
  end

  def is_carrying_equipment?
    equipment_id != 5
  end
end
