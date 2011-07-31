class Url < ActiveRecord::Base
  has_many :tweets_urls
  has_many :tweets, :through =>:tweets_urls
end

