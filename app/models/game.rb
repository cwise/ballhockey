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
  
  cattr_reader :per_page
  @@per_page = 10

  def number_playing
    playing_players.size
  end

  def mail_invites
    HockeyMailer.deliver_announce_game(self)
  end

  def playing_players
    game_players.select{|gp| gp.player_status_id > 2}
  end
  
  def not_playing_players
    game_players.select{|gp| gp.player_status_id == 2}
  end
  
  def not_responded_players
    game_players.select{|gp| gp.player_status_id == 1}
  end  
  
  def playing_players_not_late
    playing_players.reject{|gp| gp.player_status_id==5}
  end
  
  def mail_updates
   if self.game_status_id_changed?
      if is_cancelled?
        HockeyMailer.deliver_cancel_game(self)
      elsif self.is_called?
        HockeyMailer.deliver_call_game(self)
      elsif self.is_send_update?
        HockeyMailer.deliver_update_game(self)
      end
   end

    self.game_status_id=game_status_id_was if is_send_update?
  end

  def all_players
    players=Array.new
    game_players.each do |p|
      if(p.player.has_email?)
        players << p.player.email_address
      end
    end
    players
  end

  def is_send_update?
    return game_status_id==4
  end

  def is_cancelled?
    return game_status_id==3
  end

  def is_called?
    return game_status_id==2
  end

  def was_played?
    return is_called?
  end

  def self.current_game
    Game.find_by_game_date(Date.today)
  end

  def goalies
    playing_players.select{|pp| pp.goalie}.map{|pp| pp.player.name}.join(', ')
  end

  def full_message
    message + " (<a href='mailto:#{organizer_address}'>#{organizer}</a>)"
  end

  def on_deck
    playing_players_not_late.sort_by { |gp| gp.player.goalie_factor }.last
  end
end
