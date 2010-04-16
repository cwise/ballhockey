class GamePlayerController < ApplicationController
  def playing
    @game_player=GamePlayer.find(params[:id])
    @game_player.player_status_id=3
    @game_player.save

    render :text => "Confirmed as Playing"
  end

  def not_playing
    @game_player=GamePlayer.find(params[:id])
    @game_player.player_status_id=2
    @game_player.save

    render :text => "Confirmed as NOT Playing"
  end

  def maybe
    @game_player=GamePlayer.find(params[:id])
    @game_player.player_status_id=4
    @game_player.save

    render :text => "Confirmed as a Maybe"
  end

  def late
    @game_player=GamePlayer.find(params[:id])
    @game_player.player_status_id=5
    @game_player.save

    render :text => "Confirmed as Late"
  end

end
