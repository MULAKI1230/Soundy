class PlaylistsController < ApplicationController
  def index
    if params[:search].present?
    @playlists = Playlist.where("LOWER(name) LIKE ?", "#{params[:q].downcase}%")
  else
    @playlists = Playlist.all
  end
end

  def show
    @playlist = Playlist.find(params[:id])
  end

  def new
    @playlist = Playlist.new
  end

  def create
    @playlist = Playlist.new(playlist_params)
    if @playlist.save
      redirect_to @playlist
    else
      render :new
    end
  end

  def add_tracks
    @playlist = Playlist.find(params[:id])
    @tracks = Track.all - @playlist.tracks
  end

  def add_track
    @playlist = Playlist.find(params[:id])
    track = Track.find(params[:track_id])
    @playlist.tracks << track unless @playlist.tracks.include?(track)
    redirect_to add_tracks_playlist_path(@playlist), notice: "Track added!"
  end

  def remove_track
    @playlist = Playlist.find(params[:id])
    track = Track.find(params[:track_id])
    @playlist.tracks.delete(track)
    redirect_to @playlist, notice: "Track removed!"
  end

  def destroy
    @playlist = Playlist.find(params[:id])
    @playlist.destroy
    redirect_to playlists_path, notice: "Playlist deleted!"
  end
  
  private

  def playlist_params
    params.require(:playlist).permit(:name, :description, track_ids: [])
  end
end
