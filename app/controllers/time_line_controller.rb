class TimeLineController < ApplicationController
  def index
    @client = twitter_client
    @client.home_timeline.each do |r|
      tweet = Tweet.new

      tweet[:id] = r.id
      tweet[:text] = r.text
      tweet[:retweeted] = r.retweeted
      tweet[:retweet_count] = r.retweet_count
      tweet[:favorited] = r.favorited
      tweet[:created_at] = r.created_at
      tweet.save
    end
  end

end
