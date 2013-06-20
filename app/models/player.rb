class Player < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_uniqueness_of :email_address
  scope :active, where(:active => true)
  scope :search, lambda {|q| q.blank? ? scoped : where(["lower(name) LIKE ? OR email_address LIKE ?", "%#{q.downcase}%", "%#{q.downcase}%"])}  
  has_many :game_players, :dependent => :destroy
  has_many :games, :through => :game_players
  
  PLAYER_STATUSES=[:no_response, :in, :out, :late]

  def active_desc
    active ? 'Yes' : 'No'
  end

  def times_played_goalie
    game_players.played_games.select{ |gp| gp.goalie? }.size
  end

  def played_games
    game_players.played_games.map(&:game)
  end

  def played_games_goalie
    game_players.played_games.select{ |gp| gp.goalie? }.map(&:game)
  end

  def times_played
    played_games.size
  end

  def last_played_goalie
    game = played_games_goalie.sort_by{|g| g.game_date}.last
    game ? game.game_date : 'Never'
  end

  def last_played
    game = played_games.sort_by{|g| g.game_date}.last
    game ? game.game_date : 'Never'
  end

  def goalie_factor
    unless times_played < 5
      unless times_played_goalie.zero?
        100-((times_played_goalie.to_f/times_played.to_f)*100)
      else
        100
      end
    else
      0
    end
  end

  def has_email?
    !email_address.nil? && email_address.length > 0
  end
  
  def autocomplete_response
     {"id" => id, "label" => name, "value" => email_address}
  end  
  
  def can_delete?
    game_players.playing.size==0
  end
end
