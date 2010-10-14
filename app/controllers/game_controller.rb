class GameController < ApplicationController
  def index
    @games=Game.paginate(:order => 'game_date desc', :page => params[:page])
    respond_to do |format|
      format.html
    end
  end

  def current
    current_game=Game.current_game
    if current_game
      redirect_to({:action => 'view', :id => current_game.id})
    else
      redirect_to({:action => 'no_current_game'})
    end
  end

  def new
    @game=Game.new(params[:game])
    @game.game_status_id=1
    build_lists(false)
    
    if request.post?
      params.each do |id, value|
        if(id.match(/^game_player/))
          @game.game_players.build(value)
        end
      end

      if @game.save
        flash[:notice] = 'Game add succeeded'
        redirect_to({:action => 'index'})
      else
        flash[:notice] = 'Game add failed'
        build_lists(false)
        render :action => 'edit'
      end
    else
      #need to add the default players
      @players=Player.find(:all, :conditions => "active = 1")
      @players.each { |pl| @game.game_players << GamePlayer.new do |gp|
          gp.player_id=pl.id
          gp.equipment_id=5 #none
          gp.player_status_id=1 #no response
        end }

      #use the same form for editting
      render :action => 'edit'
    end
  end

  def edit
    @game=Game.find(params[:id])
    @game.old_game_status_id=@game.game_status_id
    build_lists(true)
    
    if request.post?
      @game.attributes=params[:game]
      @game.game_players.each do | gp |
        values=params["game_player_#{gp.player_id}"]
        gp.update_attributes(values)
      end
      if @game.save
        flash[:notice] = 'Game update succeeded'
        redirect_to({:action => 'index'})
      else
        flash[:notice] = 'Game update failed'
        build_lists(true)
        render :action => 'edit'
      end
    end
  end

  def destroy
#    @game=Game.find(params[:id])
#    @game.delete
    redirect_to :back
  end

  def view
    @game=Game.find(params[:id])
    @view_only=true
    render :action => 'edit'
  end

  protected
  def build_lists(is_edit)
    @player_statuses=PlayerStatus.find(:all, :conditions => "description <> 'Maybe'")
    @game_statuses=GameStatus.find(:all, :conditions => ['description <> ? ', 'Send Update']) unless is_edit
    @game_statuses=GameStatus.find(:all) if is_edit
    @equipment=Equipment.find(:all)
  end
end
