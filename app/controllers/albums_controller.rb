class AlbumsController < ApplicationController
  def index
    @albums = Album.all.includes(:artist, :tracks)
  end

  def show
    @album = Album.find(params[:id])
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    if params[:album][:cover_image]
      uploaded_io = params[:album][:cover_image]
      filename = SecureRandom.hex + File.extname(uploaded_io.original_filename)
      filepath = Rails.root.join('public', 'album', filename)
      FileUtils.mkdir_p(File.dirname(filepath))
      File.open(filepath, 'wb') { |f| f.write(uploaded_io.read) }
      @album.cover_image = "/album/#{filename}"
    end
    if @album.save
      redirect_to @album
    else
      render :new
    end
  end

  private

  def album_params
    params.require(:album).permit(:title, :artist_id, :year, :cover_image)
  end
end
