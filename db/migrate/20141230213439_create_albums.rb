class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.belongs_to :artist, index: true

      t.string :name
      t.integer :artist_id

      t.timestamps
    end

  end
end
