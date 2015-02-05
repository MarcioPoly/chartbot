class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.belongs_to :artist, index: true
      t.belongs_to :album, index: true

      t.string :name
      t.integer :artist_id
      t.integer :album_id

      t.timestamps
    end
  end
end
