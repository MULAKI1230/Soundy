class AddProfileImageToArtists < ActiveRecord::Migration[6.1]
  def change
    add_column :artists, :profile_image, :string
  end
end
