class GamePlayerController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:auto_complete_for_email_address]
#  auto_complete_for :game_player, :email_address

  def update_status
    @game=Game.find(params[:id])
    @player_statuses=PlayerStatus.find(:all, :conditions => 'id <> 1 AND id <> 5', :order => :description)

    if request.post?
      @game_player=GamePlayer.new(params[:game_player])
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
    end
  end

  def auto_complete_for_email_address
    email_address=params[:game_player][:email_address]
    @players=Player.find_by_email_address(:all , :conditions => "email_address like '%"+email_address.downcase+"%'")
    render :partial => 'email_address'
  end
end
