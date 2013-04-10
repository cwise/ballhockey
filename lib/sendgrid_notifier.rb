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
      player = Player.where(:email_address => email).first
      gp = GamePlayer.where('game_id = ? AND player_id = ?', game.id, player.id)
      
      # we need to do something to guard against out of sequence events
      case event
      when 'deferred'
        gp.update_attribute(:delivery_state, event) if gp.sent?          
      when 'processed'
        gp.update_attribute(:delivery_state, event) if gp.sent? || gp.deferred?
      when 'dropped'
        gp.update_attribute(:delivery_state, event) if gp.sent? || gp.deferred?
      when 'delivered'
        gp.update_attribute(:delivery_state, event) if gp.sent? || gp.processed? || gp.deferred?      
      when 'bounce'
        gp.update_attribute(:delivery_state, event) if gp.sent? || gp.processed? || gp.deferred?
      else
        gp.update_attribute(:delivery_state, event)
      end

    end
  end  
end