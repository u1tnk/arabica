class CreateTweetsUrls < ActiveRecord::Migration
  def change
    create_table :tweets_urls, :id => false do |t|
      t.references :tweet
      t.references :url
    end
    add_index :tweets_urls, [:tweet_id, :url_id], :unique => true
    add_index :tweets_urls, :url_id
  end
end
