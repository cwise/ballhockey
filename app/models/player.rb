class Player < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_uniqueness_of :email_address

  has_many :played_games

  cattr_reader :per_page
  @@per_page = 10

  def active_desc
    if(active)
      "Yes"
    else
      "No"
    end
  end

  def times_played_goalie
    goalie_count=0
      played_games.each do |pg|
      if pg.goalie
        goalie_count=goalie_count+1
      end
    end
    goalie_count
  end

  def times_played
    played_games.size
  end

  def last_played_goalie
    last_date=nil
    played_games.each do |pg|
      if pg.goalie && (last_date.nil? || last_date < pg.game_date)
        last_date=pg.game_date
      end
    end
    if last_date.nil?
      last_date='Never'
    end
    last_date
  end

  def last_played
    last_date=nil
    played_games.each do |pg|
      if (last_date.nil? || last_date < pg.game_date)
        last_date=pg.game_date
      end
    end
    if last_date.nil?
      last_date='Never'
    end
    last_date
  end

  def goalie_factor
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
end
