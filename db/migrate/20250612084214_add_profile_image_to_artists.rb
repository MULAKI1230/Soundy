class AddProfileImageToArtists < ActiveRecord::Migration[8.0]
  def change
    add_column :artists, :Profile_Image, :string
  end
end
