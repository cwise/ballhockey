class SendgridNotifier 
  @queue = :sendgrid_notifier_queue
  def self.perform(message)  
	  msg_type = message['type']
    id = message['id']
    event = message['event']
    email = message['email']
    return if msg_type.nil? || id.nil?
    
    if msg_type=="game"
      game = Game.find id.to_i
      
      # with the game in hand, locate the player
      player = Player.where(:email => email).first
      gp = GamePlayer.where('game_id = ? AND player_id = ?', game.id, player.id)
      
      gp.update_attribute(:delivery_state, event)
    end
  end  
end