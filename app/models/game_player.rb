class GamePlayer < ActiveRecord::Base
  include AASM
  
  belongs_to :game
  belongs_to :player
  belongs_to :equipment
  belongs_to :player_status
  attr_accessor :email_address
  scope :not_responded, where(:current_state => :no_response)
  scope :not_playing, where(:current_state => :out)
  scope :playing, where(:current_state => [:in, :late])
  scope :not_late, where(:current_state => :in)
  scope :goalie, where(:goalie => true)
  
  aasm_column :current_state
  aasm_initial_state :no_response
  aasm_state :out
  aasm_state :in
  aasm_state :late  
  
  def name_with_status
    name=player.name
    name += " (" + player_status.description + ")" if late?
    name += " (" + equipment.try(:description) + ")" if carrying_equipment?
#    name += " (On Deck)" if self==game.on_deck
    name
  end

  def late?
    current_state==:late
  end

  def carrying_equipment?
    equipment_id != 5
  end
end
