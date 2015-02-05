#!/usr/bin/env ruby

require 'rubygems'
require 'chatterbot/dsl'
require 'active_resource'


# this is the script for the twitter bot WRFLChartBot
# generated on 2015-01-21 17:10:31 -0500


class Follower < ActiveResource::Base

  def self.follower_cache

    followers_list = followers

    followers_list.each do |follower|


      entry = Follower.new(follower: follower.screen_name, tweet_date: nil)

      entry.save

    end

  end

  def self.question

    followers = Follower.all

    followers[rand(followers.count)]
    #@WRFLOriginalCon
    #twitter id: 2660217597
    #chartbot id: 75


  end


  #TODO: LEARN HOW TO USE OAUTH FOR THIS REQUEST
  # TODO: The play here is convert twitter id#'s to usernames in order to tweet questions to random followers.'
  def self.tweet_oc

    consumer_key 'CQsRWmKnku4gH50mPyGxRLc3a'
    consumer_secret 'XyvkFN6wfavmRrTqM8FaziM0bgTkxv7okNf9ggBDCTghgpVImS'

    secret 'TbIFP1cWHr6zUczg2kDhoRoFrg5mNpmuXdfRKnFGKT6TF'
    token '2727339115-9kpB4zBOB9S4N9u7PiTBUk4Jfck3W93YQz7Bnd7'

    puts Follower.find(2660217597)

  end
  # https://api.twitter.com/1.1/users/lookup.json?user_id=2660217597


end

