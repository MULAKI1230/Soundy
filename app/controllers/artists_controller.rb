class ArtistsController < ApplicationController
  def index
    @artists = Artist.all.includes(:albums, :tracks)
  end

  def show
    @artist = Artist.find(params[:id])
  end

  def new
    @artist = Artist.new
  end

  def create
  @artist = Artist.new(artist_params.except(:profile_image))
  if params[:artist][:profile_image]
    uploaded_io = params[:artist][:profile_image]
    filename = SecureRandom.hex + File.extname(uploaded_io.original_filename)
    filepath = Rails.root.join('public', 'artist', filename)
    FileUtils.mkdir_p(File.dirname(filepath))
    File.open(filepath, 'wb') { |f| f.write(uploaded_io.read) }
    @artist.Profile_Image = "/artist/#{filename}"
  end
    if @artist.save
      redirect_to @artist
    else
      render :new
    end
  end

  private

  def artist_params
    params.require(:artist).permit(:name, :bio)
  end
end
