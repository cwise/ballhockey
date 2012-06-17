class Player < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_uniqueness_of :email_address
  scope :active, where(:active => true)
  scope :search, lambda {|q| q.blank? ? scoped : where(["lower(name) LIKE ? OR email_address LIKE ?", "%#{q.downcase}%", "%#{q.downcase}%"])}  
  has_many :game_players
  has_many :games, :through => :game_players
  
  PLAYER_STATUSES=[:no_response, :in, :out, :late]
  
  cattr_reader :per_page
  @@per_page = 10

  def active_desc
    active ? 'Yes' : 'No'
  end

  def times_played_goalie
    played_games_goalie.size
  end

  def played_games_goalie
    played_games.select{|g| game_players.goalie.map{|gp| gp.game_id}.include? g.id}
  end
  
  def played_games
    game_players.playing.map{|gp| gp.game}.select{|g| g.was_played?}
  end

  def times_played
    played_games.size
  end

  def last_played_goalie
    game=played_games_goalie.sort_by{|g| g.game_date}.last
    game ? game.game_date : 'Never'
  end

  def last_played
    game=played_games.sort_by{|g| g.game_date}.last
    game ? game.game_date : 'Never'
  end

  def goalie_factor
    return 0
    unless times_played < 5
      unless times_played_goalie==0
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
end
