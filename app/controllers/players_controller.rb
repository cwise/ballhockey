class PlayersController < ApplicationController  
  before_filter :admin_required, :except => [:summary, :on_deck]
  before_filter :load_player, :only => [:show, :edit, :update, :destroy]
  
  def index
    @players=Player.order(:name).page(params[:page]).per(20)
    respond_to do |format|
      format.html
    end
  end

  def search
    @players=Player.search(params[:term]).order("lower(name)")
    
    respond_to do |format|
      format.json { render :json => @players.collect {|player| player.autocomplete_response } }
    end
  end
  
  def new
    @player=Player.new
  end
  
  def create
    @player=Player.new(params[:player])

    respond_to do |format|
      if @player.save
        flash[:notice]='Player add succeeded'
        format.html { redirect_to players_path }
      else
        format.html { render :action => 'new' }
      end
    end
  end  
  
  def update
    @player.attributes=params[:player]
    
    respond_to do |format|
      if @player.save
        flash[:notice]='Player update succeeded'
        format.html { redirect_to players_path }
      else
        flash[:notice] = 'Player update failed'
        format.html { render :action => 'edit' }        
      end
    end
  end

  def destroy
    @player.destroy
    flash[:alert]="Successfully deleted #{@player.name}"
    redirect_to players_path
  end  

  def summary
    @players=Player.all
    @players.sort!{|a,b| b.times_played <=> a.times_played}
  end

  def on_deck
    @players=Player.active.includes(:played_games).all
    @sorted_players=@players.to_a.sort do |a,b|
      comp=b.goalie_factor <=> a.goalie_factor
      comp.zero? ? (comp=(a.times_played_goalie <=> b.times_played_goalie)) : comp
      comp.zero? ? (comp=(a.last_played_goalie <=> b.last_played_goalie)) : comp
      comp.zero? ? (comp=(b.times_played <=> a.times_played)) : comp
      comp.zero? ? (comp=(a.name <=> b.name)) : comp
    end
  end
  
  private
  def load_player
    @player=Player.find(params[:id])
  end
end
