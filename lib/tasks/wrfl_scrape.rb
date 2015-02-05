#!/usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'pp'
require 'date'
require 'time'
require 'action_controller'
require 'chatterbot/dsl'


namespace :db do
  desc 'update the database with new songs'
  task :scrape do
    scrape
  end
end

ALBUM_FIX = ["(s\\/t)", "s\\/t ", "s\\/t", "12\"", "45rpm", "7\"", "45", ".", "12'", "(45)"]

def wrfl_insert (song)

  artist = Artist.where(name: "#{song[1]}").first_or_initialize
  artist.save if artist.valid?

  Album.transaction do
    $album = Album.where(name: "#{song[3]}", artist_id: artist.id).first_or_initialize
    $album.save! if $album.valid?
  end

  track = Track.where(name: "#{song[2]}", album_id: $album.id, artist_id: artist.id).first_or_initialize
  track.save if track.valid?

  Play.where(track_id: track.id, album_id: $album.id, artist_id: artist.id, playdate: song[0] || Time.now, djname: song[4]).first_or_create

end

def scrape (pages = 1)

  while pages > 0 do

    dates = Array.new #create arrays to temporarily store scraped data
    artists = Array.new
    tracks = Array.new
    albums = Array.new
    djnames = Array.new

    #begin playlist scrape
    page = Nokogiri::HTML(open("http://wrfl.fm/en/playlist/?page=#{pages}")) #run nokogiri, find page, return

    page.css('span#plDate').each do |plDate| #use css method on the loaded page, iterate through each instance of the element
      dates << plDate.content
    end

    # Begin Date formatter
    dates.each{|date| date.gsub!('noon','12 pm')}
    dates.each {|date| date.insert(10,' ')} #insert space between date and time
    dates.each{|date| date.gsub!('.','')}  #removes .'s from meridian
    dates.each{|date| date.insert(-4,':00') if date.length < 18} #convert 5 pm to '5:00 pm'
    dates.map!{|date| DateTime.strptime(date,'%m/%d/%Y %l:%M %P').strftime('%Y-%m-%d %H:%M:%S') rescue next} #convert from 12hr to 24hr clock
    # End Date formatter


    page.css('span#plArtist').each do |plArtist|
      artists << plArtist.content.downcase
    end

    page.css('span#plTrack').each do |plTrack|
      tracks << plTrack.content.downcase
    end

    page.css('span#plAlbum').each do |plAlbum|
      albums << plAlbum.content.downcase
    end

    page.xpath('//td/a').each do |djname|
      djnames << djname.content.downcase
    end
    #END SCRAPES

    #compile scrapes into array of songs:
    newtracks = Array.new
    (0..dates.length - 1).each do |index| #iterates through the table, adding each entry to newtracks
      newtracks << [dates[index], artists[index], tracks[index], albums[index], djnames[index]]
    end

    newtracks.each do |song|

      song.each do |field|
        field.try(:strip)
      end

      wrfl_insert(song)

      end

    pages -= 1 #end of pagination loop

  end
  ActiveRecord::Base.connection.close
end

# def scrape_update
#   scrape #scrape backwards until unsaved playdate == newest saved playdate, reverse and insert
# end


# [{Song params},{play params}]
# 1. check if song is in Songs database (search Songs for name, then check artist)
# 2. create song in Songs database if false (create then pass id as foreign key to plays )
# 3. add play to Plays database with song_id