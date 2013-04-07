class SendgridNotifier 
  @queue = :sendgrid_notifier_queue
  def self.perform(message)  
	  msg_type=message['type']
    id=message['id']
    event=message['event']
    return if msg_type.nil?
    
    # to be implemented
    false
  end  
end