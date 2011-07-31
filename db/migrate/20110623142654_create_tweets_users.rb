class CreateTweetsUsers < ActiveRecord::Migration
  def change
    create_table :tweets_users do |t|
      t.references :tweet
      t.references :user
      t.timestamps
    end
    add_index :tweets_users, [:tweet_id, :user_id], :unique => true
    add_index :tweets_users, :user_id
  end
end
