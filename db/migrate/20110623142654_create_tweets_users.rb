class CreateTweetsUsers < ActiveRecord::Migration
  def self.up
    create_table :tweets_users, :id => false do |t|
      t.references :tweet
      t.references :user
    end
    add_index :tweets_users, [:tweet_id, :user_id], :unique => true
    add_index :tweets_users, :user_id
  end

  def self.down
    drop_table :tweets_users
  end
end
