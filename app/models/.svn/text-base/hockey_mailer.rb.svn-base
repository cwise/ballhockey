class HockeyMailer < ActionMailer::Base
  def announce_game(game)
    from MAIL_SENDER
    reply_to game.organizer_address
    recipients game.all_players
    subject "NRCan Ball Hockey Game for #{game.game_date}?"
    body :game => game
    content_type "text/html"
  end

  def update_game(game)
    from MAIL_SENDER
    reply_to game.organizer_address
    recipients game.all_players
    subject "NRCan Ball Hockey Game Update for #{game.game_date}?"
    body :game => game
    content_type "text/html"
  end

  def call_game(game)
    from MAIL_SENDER
    reply_to game.organizer_address
    recipients game.all_players
    subject "NRCan Ball Hockey Game for #{game.game_date}: Game ON!"
    body :game => game
    content_type "text/html"
  end

  def cancel_game(game)
    from MAIL_SENDER
    reply_to game.organizer_address
    recipients game.all_players
    subject "NRCan Ball Hockey Game for #{game.game_date}: Game Cancelled"
    body :game => game
    content_type "text/html"
  end
end
