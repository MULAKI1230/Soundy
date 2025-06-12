class TracksController < ApplicationController
  def index
    @tracks = Track.all.includes(:artist, :album)
  end

  def show
    @track = Track.find(params[:id])
  end

  def new
    @track = Track.new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to @crack
    else
      render :new
    end
  end

  private

  def track_params
    params.require(:track).permit(:title, :artist_id, :album_id, :audio_file)
  end
end