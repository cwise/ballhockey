class Game < ActiveRecord::Base
  validates_uniqueness_of :game_date
  validates_presence_of :message
  validates_presence_of :organizer
  validates_presence_of :organizer_address
  has_many :game_players, :dependent => :destroy
  accepts_nested_attributes_for :game_players
  belongs_to :game_status
  scope :played, where(:game_status_id => 2)
  
  after_create :mail_invites
  before_update :mail_updates

  def number_playing
    playing_players.size
  end

  def mail_invites
    HockeyMailer.announce_game(self).deliver
  end

  def playing_players
    game_players.playing
  end
  
  def not_playing_players
    game_players.not_playing
  end
  
  def not_responded_players
    game_players.not_responded
  end  
  
  def playing_players_not_late
    playing_players.not_late
  end
  
  def mail_updates
   if self.game_status_id_changed?
      if cancelled?
        HockeyMailer.cancel_game(self).deliver
      elsif self.called?
        HockeyMailer.call_game(self).deliver
      elsif self.send_update?
        HockeyMailer.update_game(self).deliver
      end
   end

    self.game_status_id=game_status_id_was if send_update?
  end

  def all_players
    game_players.select{|gp| gp.player.has_email?}.map{|gp| gp.player}
  end

  def not_called?
    game_status_id==1
  end
  
  def send_update?
    return game_status_id==4
  end

  def cancelled?
    return game_status_id==3
  end

  def called?
    return game_status_id==2
  end

  def was_played?
    return called?
  end

  def self.current_game
    Game.find_by_game_date(Date.today)
  end

  def goalies
    game_players.select{|gp| gp.goalie}.map{|gp| gp.player.name}.join(', ')
  end

  def full_message
    "#{message} (<a href='mailto:#{organizer_address}'>#{organizer}</a>)"
  end

  def on_deck
    playing_players_not_late.sort_by {|gp| gp.player.goalie_factor }.last
  end
  
  def can_delete?
    not_called?
  end
end
