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

def check_current(var)

  page = Nokogiri::HTML(open("http://wrfl.fm/playlist")) #run nokogiri, find page, return

    track = page.css('span#currentTrack').text
    artist = page.css('span#currentArtist').text
    dj = page.css('div#djname').text.strip
    dj_name = dj.gsub('Current On-Air DJ: ', '')
    current_dj_profile = "http://wrfl.fm/en/user/#{dj_name}/"

      if var == :track
        "Current track: #{track} by #{artist} #WRFL"
      elsif var == :djname
        "#{dj} #WRFL #{current_dj_profile}"
      end

end

# replies do |tweet|
#   reply "I hear you, #USER#", tweet
# end

loop do
replies do |tweet|
  # replace the incoming username with #USER#, which will be replaced
  # with the handle of the user who tweeted us by the
  # replace_variables helper

  src = tweet[:text]

  if src.gsub(/[^0-9a-z ]/i,'').downcase.include?("whats playing")
    reply ".#USER# #{check_current(:track)}", tweet
  elsif src.gsub(/[^0-9a-z ]/i,'').downcase.include?("whos on")
    reply ".#USER# #{check_current(:djname)}", tweet
  end

  update_config
end

#
# search "keyword" do |tweet|
#   reply "Hey #USER# nice to meet you!", tweet
# end
#
# replies do |tweet|
#   reply "Yes #USER#, you are very kind to say that!", tweet
# end
sleep(90)
end

# TODO: add periodic/random tweets instructing followers to ask questions about songs/djs  Goes in chatter.rb?
