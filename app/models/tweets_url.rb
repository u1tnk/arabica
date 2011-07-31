class TweetsUrl < ActiveRecord::Base
  belongs_to :tweet
  belongs_to :url
end

