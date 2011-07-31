class Tweet < ActiveRecord::Base
  has_many :tweets_users
  has_many :tweets_urls
  has_many :users, :through => :tweets_users
  has_many :urls, :through => :tweets_urls
end
