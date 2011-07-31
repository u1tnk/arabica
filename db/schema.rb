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

ActiveRecord::Schema.define(:version => 20110704142200) do

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "tweets", :force => true do |t|
    t.text     "text"
    t.boolean  "retweeted"
    t.integer  "retweet_count"
    t.boolean  "favorited"
    t.integer  "twitter_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tweets_urls", :force => true do |t|
    t.integer  "tweet_id"
    t.integer  "url_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tweets_urls", ["tweet_id", "url_id"], :name => "index_tweets_urls_on_tweet_id_and_url_id", :unique => true
  add_index "tweets_urls", ["url_id"], :name => "index_tweets_urls_on_url_id"

  create_table "tweets_users", :force => true do |t|
    t.integer  "tweet_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tweets_users", ["tweet_id", "user_id"], :name => "index_tweets_users_on_tweet_id_and_user_id", :unique => true
  add_index "tweets_users", ["user_id"], :name => "index_tweets_users_on_user_id"

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
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "urls", ["url"], :name => "index_urls_on_url", :unique => true

  create_table "users", :force => true do |t|
    t.string   "provider",          :null => false
    t.string   "uid",               :null => false
    t.string   "screen_name",       :null => false
    t.string   "name",              :null => false
    t.string   "profile_image_url", :null => false
    t.string   "access_token",      :null => false
    t.string   "access_secret",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["provider", "screen_name"], :name => "index_users_on_provider_and_screen_name", :unique => true
  add_index "users", ["provider", "uid"], :name => "index_users_on_provider_and_uid", :unique => true

end
