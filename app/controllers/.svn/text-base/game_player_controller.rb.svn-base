class GamePlayerController < ApplicationController
  def update_status
    @game=Game.find(params[:id])
    @player_statuses=PlayerStatus.find(:all, :conditions => "description NOT IN ('Maybe', 'No response')", :order => :description)

    if request.post?
      @game_player=GamePlayer.new(params[:game_player])
      cookies.permanent[:email_address]=@game_player.email_address
      player=Player.find_by_email_address(@game_player.email_address)
      if player.nil?
        @game_player.errors.add("Player not found by address") 

        render :update_status
      else
        gp=GamePlayer.find_by_game_id_and_player_id(@game.id, player.id)
        gp.player_status_id=@game_player.player_status_id
        gp.save

        render :text => "Confirmed #{player.name} as #{gp.player_status.description}"
      end
    else
      @game_player=GamePlayer.new
      logger.info("cookies=#{cookies}")
      @game_player.email_address=cookies[:email_address]
    end
  end
end
