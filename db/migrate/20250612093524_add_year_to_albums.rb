class AddYearToAlbums < ActiveRecord::Migration[8.0]
  def change
    add_column :albums, :year, :integer
  end
end
