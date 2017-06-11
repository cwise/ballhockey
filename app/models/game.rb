class Game < ActiveRecord::Base
  include AASM
    
  validates_uniqueness_of :game_date
  validates_presence_of :message
  validates_presence_of :organizer
  validates_presence_of :organizer_address
  has_many :game_players, :dependent => :destroy
  accepts_nested_attributes_for :game_players
  scope :played, where("games.current_state = ?", :game_on)
  scope :not_called, where("games.current_state = ?", :not_called)
  
  after_create :mail_invites
  before_update :mail_updates

  GAME_STATUSES=[:not_called, :game_on, :cancelled, :send_update]
  
  aasm_column :current_state
  aasm_initial_state :not_called
  aasm_state :game_on
  aasm_state :cancelled
  aasm_state :send_update

  def number_playing
    playing_players.size
  end

  def friendly_state
    current_state.titleize
  end

  def mail_invites
    HockeyMailer.announce_game(self.id).deliver
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
  
  def not_called?
    current_state=="not_called"
  end
  
  def called?
    current_state=="game_on"
  end
  
  def was_played?
    called?
  end
  
  def bs_state
    case current_state
    when 'game_on'
      'success'
    when 'cancelled'
      'important'
    when 'not_called'
      game_players.playing.size < 8 ? 'warning' : 'info'
    end
  end
  
  def mail_updates
   if self.current_state_changed?
      if cancelled?
        HockeyMailer.cancel_game(self.id).deliver
      elsif self.called?
        HockeyMailer.call_game(self.id).deliver
      elsif self.send_update?
        HockeyMailer.update_game(self.id).deliver
      end
   end

    self.current_state=current_state_was if send_update?
  end

  def all_players
    game_players.select{|gp| gp.player.has_email?}.map{|gp| gp.player}
  end

  def self.current_game
    # last uncalled game
    # or today
    # or next called future game
    Game.not_called.order('game_date').first || Game.find_by_game_date(Date.today) || Game.game_on.where('game_date >= ?', Date.today).order('game_date').first 
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
