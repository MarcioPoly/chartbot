class AddCounterToTrack < ActiveRecord::Migration
  def self.up
    add_column :tracks, :plays_count, :integer, :default => 1

    Track.reset_column_information
    Track.find_each do |a|
      Track.reset_counters a.id, :plays
    end
  end

  def self.down
    remove_column :tracks, :plays_count
  end
end
