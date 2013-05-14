class HockeyMailer < ActionMailer::Base
  include Resque::Mailer
  default :from => ENV['MAIL_SENDER']  
  
  def announce_game game_id
    kill_stale_workers
    load_game game_id
    uniq_args({ :type => 'game', :id => @game.id })    
    mail base_options.merge({ :subject => "#{ENV['LEAGUE_NAME']} Ball Hockey Game for #{@game.game_date}?"})
  end

  def update_game game_id
    kill_stale_workers
    load_game game_id
    uniq_args({ :type => 'game', :id => @game.id })    
    mail base_options.merge({ :subject => "#{ENV['LEAGUE_NAME']} Ball Hockey Game Update for #{@game.game_date}"})
  end

  def call_game game_id
    kill_stale_workers
    load_game game_id
    uniq_args({ :type => 'game', :id => @game.id })    
    mail base_options.merge({ :subject => "#{ENV['LEAGUE_NAME']} Ball Hockey Game for #{@game.game_date}: Game ON!"})
  end

  def cancel_game game_id
    kill_stale_workers
    load_game game_id
    uniq_args({ :type => 'game', :id => @game.id })    
    mail base_options.merge({ :subject => "#{ENV['LEAGUE_NAME']} Ball Hockey Game for #{@game.game_date}: Game Cancelled"})
  end
  
  def test to
    kill_stale_workers
    mail :to => to, :content_type => "text/html", :subject => 'Test Message'
  end
  
  private
  def base_options
    { :reply_to => @game.organizer_address, :content_type => "text/html", :to => @game.all_players.map{|p| p.email_address} }
  end
  
  def load_game game_id
    @game = Game.find game_id
  end
  
  def kill_stale_workers
    Resque.workers.each{ |w| w.unregister_worker }
  end
end
