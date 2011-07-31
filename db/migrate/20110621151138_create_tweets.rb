class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.text :text
      t.boolean :retweeted
      t.integer :retweet_count
      t.boolean :favorited
      t.references :twitter_user

      t.timestamps
    end
  end
end
