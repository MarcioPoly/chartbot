# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150201034934) do

  create_table "albums", force: true do |t|
    t.integer  "artist_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "plays_count", default: 0
  end

  add_index "albums", ["artist_id"], name: "index_albums_on_artist_id"

  create_table "artists", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "plays_count", default: 0
  end

  create_table "followers", force: true do |t|
    t.string   "follower"
    t.datetime "tweet_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plays", force: true do |t|
    t.datetime "playdate"
    t.integer  "track_id"
    t.integer  "artist_id"
    t.integer  "album_id"
    t.string   "djname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "plays", ["album_id"], name: "index_plays_on_album_id"
  add_index "plays", ["artist_id"], name: "index_plays_on_artist_id"
  add_index "plays", ["track_id"], name: "index_plays_on_track_id"

  create_table "tracks", force: true do |t|
    t.integer  "artist_id"
    t.integer  "album_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "plays_count", default: 0
  end

  add_index "tracks", ["album_id"], name: "index_tracks_on_album_id"
  add_index "tracks", ["artist_id"], name: "index_tracks_on_artist_id"

  create_table "tweets", force: true do |t|
    t.string   "description"
    t.string   "query"
    t.datetime "next_tweet"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
