class GamesController < ApplicationController
  before_filter :admin_required, :except => [:current, :show, :no_current_game, :player_status, :update_player_status]
  before_filter :load_game, :only => [:show, :edit, :update, :destroy, :player_status, :update_player_status]
  
  def index
    @games=Game.order('game_date desc').paginate(:page => params[:page])
    
    respond_to do |format|
      format.html
    end
  end

  def current
    current_game=Game.current_game
    if current_game
      redirect_to game_path(current_game)
    else
      redirect_to({:action => 'no_current_game'})
    end
  end

  def new
    @game=Game.new(params[:game])
    @game.game_status_id=1
    build_lists
    
    @players=Player.active.all
    @players.each{|pl| @game.game_players << GamePlayer.new(:player_id => pl.id, :equipment_id => 5, :player_status_id => 1) }

    respond_to do |format|
      format.html
    end
  end
  
  def create
    @game=Game.new(params[:game])

    if @game.save
      flash[:notice] = 'Game add succeeded'
      redirect_to({:action => 'index'})
    else
      flash[:notice] = 'Game add failed'
      build_lists
      render :action => 'new'
    end
  end

  def edit
    build_lists true
    
    respond_to do |format|
      format.html
    end  
  end
  
  def update
    build_lists true
    @game.attributes=params[:game]

    respond_to do |format|
      if @game.save
        flash[:notice] = 'Game update succeeded'
        format.html { redirect_to games_path }
      else
        flash[:notice] = 'Game update failed'
        build_lists true
        format.html { render :action => 'edit' }
      end
    end
  end

  def player_status
    @game_player=GamePlayer.new
    @game_player.email_address=cookies[:email_address]    
	  @player_statuses=Player::PLAYER_STATUSES
  end
  
	def update_player_status
	  @player_statuses=Player::PLAYER_STATUSES
    @game_player=GamePlayer.new(params[:game_player])
    cookies[:email_address]={ :value => @game_player.email_address, :expires => 1.year.from_now }
    
    player=Player.where(:email_address => @game_player.email_address).first
    
    respond_to do |format|
      unless player
        flash[:alert]="Player not found by address"
        format.html { render :action => :player_status }
      else
        gp=GamePlayer.where(["game_id = ? AND player_id = ?", @game.id, player.id]).first
        gp.player_status_id=@game_player.player_status_id
        gp.save

        format.html { render :text => "Confirmed #{player.name} as #{gp.player_status.description}" }
      end
    end
	end

  def destroy
    @game.delete
    flash[:alert]="Successfully deleted #{@game.game_date}"
    redirect_to games_path
  end

  def show
  end

  protected
  def build_lists is_edit=false
    @player_statuses=Player::PLAYER_STATUSES
    @game_statuses=GameStatus.find(:all, :conditions => ['description <> ? ', 'Send Update']) unless is_edit
    @game_statuses=GameStatus.find(:all) if is_edit
    @equipment=Equipment.find(:all)
  end
  
  private
  def load_game
    @game=Game.find(params[:id])
  end  
end
