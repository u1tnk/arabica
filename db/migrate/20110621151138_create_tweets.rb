class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :tweets do |t|
      t.text :text
      t.boolean :retweeted
      t.integer :retweet_count
      t.boolean :favorited
      t.references :twitter_user

      t.timestamps
    end
  end

  def self.down
    drop_table :tweets
  end
end
