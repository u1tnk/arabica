class AddTweetsUsers < ActiveRecord::Migration
  def self.up
    create_table :tweets_users, :id => false do |t|
      t.references :tweet
      t.references :user
    end
  end

  def self.down
    drop_table :tweets_users
  end
end
