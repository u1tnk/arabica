class Tweet < ActiveRecord::Base
  belongs_to :user
  belongs_to :twitter_user
  has_and_belongs_to_many :urls
end
