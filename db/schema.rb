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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110623142654) do

  create_table "tweets", :force => true do |t|
    t.text     "text"
    t.boolean  "retweeted"
    t.integer  "retweet_count"
    t.boolean  "favorited"
    t.integer  "twitter_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tweets_urls", :id => false, :force => true do |t|
    t.integer "tweet_id"
    t.integer "url_id"
  end

  create_table "tweets_users", :id => false, :force => true do |t|
    t.integer "tweet_id"
    t.integer "user_id"
  end

  create_table "twitter_users", :force => true do |t|
    t.string   "name"
    t.string   "screen_name"
    t.string   "location"
    t.string   "description"
    t.string   "profile_image_url"
    t.string   "url"
    t.boolean  "protected"
    t.string   "profile_background_color"
    t.string   "profile_sidebar_fill_color"
    t.string   "profile_link_color"
    t.string   "profile_sidebar_border_color"
    t.string   "profile_text_color"
    t.string   "profile_background_image_url"
    t.boolean  "profile_background_tile"
    t.integer  "friends_count"
    t.integer  "statuses_count"
    t.integer  "followers_count"
    t.integer  "favourites_count"
    t.integer  "utc_offset"
    t.string   "time_zone"
    t.boolean  "default_profile"
    t.boolean  "follow_request_sent"
    t.boolean  "notifications"
    t.boolean  "following"
    t.integer  "listed_count"
    t.boolean  "show_all_inline_media"
    t.boolean  "geo_enabled"
    t.boolean  "profile_use_background_image"
    t.boolean  "default_profile_image"
    t.boolean  "contributors_enabled"
    t.boolean  "verified"
    t.string   "lang"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "urls", :force => true do |t|
    t.text     "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "twitter_id"
    t.string   "login"
    t.string   "access_token"
    t.string   "access_secret"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "name"
    t.string   "location"
    t.string   "description"
    t.string   "profile_image_url"
    t.string   "url"
    t.boolean  "protected"
    t.string   "profile_background_color"
    t.string   "profile_sidebar_fill_color"
    t.string   "profile_link_color"
    t.string   "profile_sidebar_border_color"
    t.string   "profile_text_color"
    t.string   "profile_background_image_url"
    t.boolean  "profile_background_tile"
    t.integer  "friends_count"
    t.integer  "statuses_count"
    t.integer  "followers_count"
    t.integer  "favourites_count"
    t.integer  "utc_offset"
    t.string   "time_zone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
