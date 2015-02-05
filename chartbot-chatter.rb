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

# TODO: create a list of Marketing Tweets (in the model, man) EG: unique, popular, what's your favorite thing about WRFL?, Show ____ some love and retweet!, Block Show Alerts, and spit them out here