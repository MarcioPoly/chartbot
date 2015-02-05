class CreatePlays < ActiveRecord::Migration
  def change
    create_table :plays do |t|
      t.datetime :playdate
      t.integer :track_id
      t.integer :artist_id
      t.integer :album_id
      t.string :djname

      t.belongs_to :track, index: true
      t.belongs_to :album, index: true
      t.belongs_to :artist, index: true

      t.timestamps
    end
  end
end
