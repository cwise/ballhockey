class PlayerController < ApplicationController
  def index
    @players=Player.paginate :order => 'name', :page => params[:page]
  end

  def new
    @player=Player.new(params[:player])

    if request.post? and @player.save
      flash[:notice] = 'Player add succeeded'
      redirect_to({:action => 'index'})
    else
      #use the same form for editting
      render :action => 'edit'
    end
  end

  def edit
    @player=Player.find(params[:id])
    if request.post?
      @player.attributes=params[:player]
      if @player.save
        flash[:notice] = 'Player update succeeded'
        redirect_to({:action => 'index'})
      else
        flash[:notice] = 'Player update failed'
      end
    end
  end

  def delete
    @player=Player.find(params[:id])
    @player.delete
    redirect_to :back
  end

  def player_summary
    @players=Player.find(:all, :include => [:played_games])
    @sorted_players=@players.to_a.sort { |a,b| b.times_played <=> a.times_played }
  end

  def goalies_on_deck
    @players=Player.find(:all, :include => [:played_games])
    @sorted_players=@players.to_a.sort do |a,b|
      comp=b.goalie_factor <=> a.goalie_factor
      comp.zero? ? (comp=(a.times_played_goalie <=> b.times_played_goalie)) : comp
      comp.zero? ? (comp=(a.last_played_goalie <=> b.last_played_goalie)) : comp
      comp.zero? ? (comp=(b.times_played <=> a.times_played)) : comp
      comp.zero? ? (comp=(a.name <=> b.name)) : comp
    end
  end
end
