class AlbumsController < ApplicationController

  def index
    @albums = Album.all.paginate(:page => params[:page])
  end

end
