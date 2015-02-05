#!/usr/bin/env ruby

require 'rubygems'
require 'chatterbot/dsl'
require_relative './config/boot'
require_relative './config/environment'


consumer_key 'CQsRWmKnku4gH50mPyGxRLc3a'
consumer_secret 'XyvkFN6wfavmRrTqM8FaziM0bgTkxv7okNf9ggBDCTghgpVImS'
secret 'TbIFP1cWHr6zUczg2kDhoRoFrg5mNpmuXdfRKnFGKT6TF'
token '2727339115-9kpB4zBOB9S4N9u7PiTBUk4Jfck3W93YQz7Bnd7'


blacklist "@WRFLChartBot, @WesternRegionFL, @starweeklysport, @FCParkside, @NthFootscrayFC, @TWRSport, @LukeDAnello, @starweeklysport, @Altonafc, @NMGSports, @westsport, @DeerParkFC, @SpotswoodFC, @FCParkside, @SunshineRoosFC, @albioncats, @7NewsMelbourne, @westernregionfl, @Glenordenhawks, @altonafc, @shfcdragons, @NthFootscrayFC, @TWRSport, @mickaylaward, @YSEagles, @theage, @RScottReedy, @LukeDAnello, @madskeryk, @edflfooty, @YouthGirls, @izzyhuntington, @sunnymontgomery, @OLoughlinLS, @bendigobank, @newbravado, @lavruban, @N08, @AndyJMead, @TWRPics, @BrimbankWeekly, @WlTTSJW, @WerribeeFC, @SHFC_Dragons, @FootyRecruits, @ManorLakesFC, @Essendon_FC, @Collingwood_FC, @womensfooty, @NorthFootscrayF, @northfootscray, @CLdeFootscray, @WyndhamWeekly, @SLSharkbite, @VolunteeringAus, @VFLnews, @FootballGeelong, @EssendonLive, @BrimbankLeader, @StAlbansRetweet"
WORD_BLACKLIST = ["footy", "melbs", "melbswest", "footscray", "hoppers", "football", ".au"]
AUS_BLACKLIST = ["melbourne", "melbs", "aus", "australia"]

loop do

    puts "Checking for #WRFL. . .#{Time.now}"

    search ("#wrfl") do |tweet|

      if AUS_BLACKLIST.any?{|place| tweet.user.location.to_s.include?(place) }
        skip
      elsif WORD_BLACKLIST.any?{|word| tweet.text.to_s.include?(word)}
        skip
      elsif tweet.user.time_zone.to_s.include?("Australian") || nil?
        skip
      end

      favorite tweet
      puts "Favorited #{tweet.user.screen_name}'s tweet: '#{tweet.text}'"

    end

   update_config
   puts "waiting. . ."
   sleep(60*60)

end


