class TracksController < ApplicationController

  def index
    @tracks = Track.order(:plays_count).paginate(:page => params[:page])
  end

end