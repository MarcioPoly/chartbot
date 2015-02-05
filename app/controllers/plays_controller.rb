class PlaysController < ApplicationController

  def index
    @plays = Play.order(:playdate).paginate(:page => params[:page])
  end

  def djname
    @plays = Play.all.where(djname: params[:djname])
  end

  def new
    @play = Play.new
  end

  def create
    #play_insert(play.rb) is multi-model database updater method
    @play = Play.play_insert(play_params)

    redirect_to :plays
  end

  private

  def play_params
    params.require(:play).permit!
  end

end
