require 'chatterbot/dsl'

class Play < ActiveRecord::Base

  belongs_to :artist, counter_cache: true
  belongs_to :album, counter_cache: true
  belongs_to :track, counter_cache: true

  accepts_nested_attributes_for :artist
  accepts_nested_attributes_for :album
  accepts_nested_attributes_for :track

  validates_presence_of :artist_id
  validates_presence_of :album_id
  validates_presence_of :track_id

  validates_uniqueness_of :playdate, :scope => [:artist_id, :album_id, :djname]

  scope :day, -> { where( :playdate => (Date.yesterday)..(Date.yesterday + 1.day)) }
  scope :week, -> { where( :playdate => (Date.yesterday - 7.days)..(Date.yesterday)) }
  scope :month, -> { where( :playdate => (Date.yesterday - 1.month)..(Date.yesterday)) }

  def self.playlist(period, model, rank = nil) #counts duplicate plays of model
    @model = model
    @period = period

    model_name = @model.to_s
    model_id = "#{model_name}_id"

    hash = send(@period).order('playdate DESC').each_with_object(Hash.new(0)){|play,counts| counts[play.instance_eval(model_id)] += 1}

    if rank != nil
      hash.to_a.sort_by{|x,y| y}.reverse.at(rank)
    else
      hash
    end

  end

  def self.play_insert(play)

      artist = Artist.where(name: "#{play[:artist_attributes][:name]}").first_or_initialize
      artist.save if artist.valid?

      Album.transaction do
        $album = Album.where(name: "#{play[:album_attributes][:name]}", artist_id: artist.id).first_or_initialize
        $album.save! if $album.valid?
      end

      track = Track.where(name: "#{play[:track_attributes][:name]}", album_id: $album.id, artist_id: artist.id).first_or_initialize
      track.save if track.valid?

      Play.where(track_id: track.id, album_id: $album.id, artist_id: artist.id, playdate: Time.now, djname: "dj test").first_or_create
  end

end