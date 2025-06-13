class TracksController < ApplicationController
  def index
    if params[:q].present?
      q = params[:q].downcase
      @tracks = Track.joins(:artist, :album)
        .where("LOWER(tracks.title) LIKE ? OR LOWER(artists.name) LIKE ? OR LOWER(albums.title) LIKE ?", "%#{q}%", "%#{q}%", "%#{q}%")
        .includes(:artist, :album)
    else
      @tracks = Track.all.includes(:artist, :album)
    end
  end

  def show
    @track = Track.find(params[:id])
  end

  def new
    @track = Track.new
  end

  def create
    @track = Track.new(track_params.except(:audio_file))
    if params[:track][:audio_file]
      uploaded_io = params[:track][:audio_file]
      filename = SecureRandom.hex + File.extname(uploaded_io.original_filename)
      filepath = Rails.root.join('public', 'music', filename)
      FileUtils.mkdir_p(File.dirname(filepath))
      File.open(filepath, 'wb') { |f| f.write(uploaded_io.read) }
      @track.audio_file = "/music/#{filename}"
    end
    if @track.save
      redirect_to @track
    else
      render :new
    end
  end

  def edit
    @track = Track.find(params[:id])
  end

  def update
    @track = Track.find(params[:id])

    # Handle upload audio baru jika ada
    if params[:track][:audio_file]
      uploaded_io = params[:track][:audio_file]
      filename = SecureRandom.hex + File.extname(uploaded_io.original_filename)
      filepath = Rails.root.join('public', 'music', filename)
      FileUtils.mkdir_p(File.dirname(filepath))
      File.open(filepath, 'wb') { |f| f.write(uploaded_io.read) }
      @track.audio_file = "/music/#{filename}"
    end

    if @track.update(track_params.except(:audio_file))
      redirect_to @track
    else
      render :edit
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @track.destroy
    redirect_to tracks_path
  end

  private

  def track_params
    params.require(:track).permit(:title, :artist_id, :album_id, :audio_file)
  end
end