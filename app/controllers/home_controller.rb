class HomeController < ApplicationController
  def index
    @game=Game.current_game
    respond_to do |format|
      format.html
    end
  end
end
