class CreateTwitterUsers < ActiveRecord::Migration
  def change
    create_table :twitter_users do |t|

      t.string :name
      t.string :screen_name
      t.string :location
      t.string :description
      t.string :profile_image_url
      t.string :url
      t.boolean :protected
      t.string :profile_background_color
      t.string :profile_sidebar_fill_color
      t.string :profile_link_color
      t.string :profile_sidebar_border_color
      t.string :profile_text_color
      t.string :profile_background_image_url
      t.boolean :profile_background_tile
      t.integer :friends_count
      t.integer :statuses_count
      t.integer :followers_count
      t.integer :favourites_count
      t.integer :utc_offset
      t.string :time_zone
      t.boolean :default_profile
      t.boolean :follow_request_sent
      t.boolean :notifications
      t.boolean :following
      t.integer :listed_count
      t.boolean :show_all_inline_media
      t.boolean :geo_enabled
      t.boolean :profile_use_background_image
      t.boolean :default_profile_image
      t.boolean :contributors_enabled
      t.boolean :verified
      t.string :lang

      t.timestamps
    end
  end
end
