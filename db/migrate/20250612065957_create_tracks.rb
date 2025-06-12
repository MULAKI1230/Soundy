class CreateTracks < ActiveRecord::Migration[8.0]
  def change
    create_table :tracks do |t|
      t.string :title
      t.references :album, null: false, foreign_key: true
      t.references :artist, null: false, foreign_key: true
      t.string :audio_file

      t.timestamps
    end
  end
end
