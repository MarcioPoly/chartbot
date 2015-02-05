#!/usr/bin/env ruby

require 'rubygems'
require 'chatterbot/dsl'
require_relative './config/boot'
require_relative './config/environment'

# this is the script for the twitter bot WRFLChartBot
# generated on 2015-01-21 17:10:31 -0500
#

consumer_key 'CQsRWmKnku4gH50mPyGxRLc3a'
consumer_secret 'XyvkFN6wfavmRrTqM8FaziM0bgTkxv7okNf9ggBDCTghgpVImS'

secret 'TbIFP1cWHr6zUczg2kDhoRoFrg5mNpmuXdfRKnFGKT6TF'
token '2727339115-9kpB4zBOB9S4N9u7PiTBUk4Jfck3W93YQz7Bnd7'

rank = 3

period = :day

if Time.now.wday == 1
  period = :week
elsif Time.now.strftime("%d") == "01"
  period = :month
end

3.times do
puts "#{Playlist.message(period, :track, rank)}"
puts "#{Playlist.message(period, :album, rank)}"
puts "#{Playlist.message(period, :artist, rank)}"
rank -= 1
end

rank = 3
3.times do
# TODO: change 'this day/week/day to date/range/day, maybe?'

album = Playlist.message(period, :album, rank)
if album[:is_valid]
  tweet album[:text]
  puts "TWEETED: #{album[:text]}"
else
  puts "PLAYS COUNT below threshold for ALBUM/#{rank}"
end

track = Playlist.message(period, :track, rank)
if track[:is_valid]
  tweet track[:text]
  puts "TWEETED: #{track[:text]}"
else
  puts "PLAYS COUNT below threshold for TRACK/#{rank}"
end

artist = Playlist.message(period, :artist, rank)
if artist[:is_valid]
  tweet artist[:text]
  puts "TWEETED: #{artist[:text]}"
else
  puts "PLAYS COUNT below threshold for ARTIST/#{rank}"
end

sleep(60*5)

rank -= 1

break if rank == 0

sleep(60 * 30)

end


# search "keyword" do |tweet|
#  reply "Hey #USER# nice to meet you!", tweet
# end
#
# replies do |tweet|
#   reply "Yes #USER#, you are very kind to say that!", tweet
# end