class AddCounterToAlbum < ActiveRecord::Migration
  def self.up
    add_column :albums, :plays_count, :integer, :default => 1

    Album.reset_column_information
    Album.find_each do |a|
      Album.reset_counters a.id, :plays
    end
  end

  def self.down
    remove_column :albums, :plays_count
  end
end
