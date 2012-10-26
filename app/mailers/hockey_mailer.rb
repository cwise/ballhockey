class HockeyMailer < ActionMailer::Base
  default :from => MAIL_SENDER  
  
  def announce_game game 
    @game = game
    mail base_options(game).merge({ :subject => "#{ENV['league_name']} Ball Hockey Game for #{game.game_date}?"})
  end

  def update_game game
    @game = game
    mail base_options(game).merge({ :subject => "#{ENV['league_name']} Ball Hockey Game Update for #{game.game_date}"})
  end

  def call_game game
    @game = game
    mail base_options(game).merge({ :subject => "#{ENV['league_name']} Ball Hockey Game for #{game.game_date}: Game ON!"})
  end

  def cancel_game game
    @game = game
    mail base_options(game).merge({ :subject => "#{ENV['league_name']} Ball Hockey Game for #{game.game_date}: Game Cancelled"})
  end
  
  private
  def base_options game
    { :reply_to => game.organizer_address, :content_type => "text/html", :to => game.all_players.map{|p| p.email_address} }
  end
end
