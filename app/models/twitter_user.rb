class TwitterUser < ActiveRecord::Base
  has_many :tweets
end
