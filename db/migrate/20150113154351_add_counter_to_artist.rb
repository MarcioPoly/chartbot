class AddCounterToArtist < ActiveRecord::Migration
  def self.up
    add_column :artists, :plays_count, :integer, :default => 1

    Artist.reset_column_information
    Artist.find_each do |a|
      Artist.reset_counters a.id, :plays
    end
  end

  def self.down
    remove_column :artists, :plays_count
  end
end
