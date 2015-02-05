class ArtistsController < ApplicationController

  def index
    @artists = Artist.all.paginate(:page => params[:page])
  end

  # def new
  #   @artist = Artist.new
  #   @artist.play.new
  # end

end
