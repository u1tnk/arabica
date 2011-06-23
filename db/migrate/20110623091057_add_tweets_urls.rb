class AddTweetsUrls < ActiveRecord::Migration
  def self.up
    create_table :tweets_urls, :id => false do |t|
      t.references :tweet
      t.references :url
    end
  end

  def self.down
    drop_table :tweets_urls
  end
end
