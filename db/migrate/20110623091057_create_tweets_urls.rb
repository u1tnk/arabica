class CreateTweetsUrls < ActiveRecord::Migration
  def change
    create_table :tweets_urls do |t|
      t.references :tweet
      t.references :url
      t.timestamps
    end
    add_index :tweets_urls, [:tweet_id, :url_id], :unique => true
    add_index :tweets_urls, :url_id
  end
end
