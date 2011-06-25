require 'uri'
require 'mechanize'

class Url < ActiveRecord::Base
  has_and_belongs_to_many :tweets

  class << self
    def filter_urls_from_tweets user, raw_tweets
      agent = Mechanize.new

      raw_tweets.each do |r|

        raw_urls = URI.extract(r.text, ['http', 'https'])
        next if raw_urls.empty?
        if Tweet.exists? r.id
          tweet = Tweet.find r.id
          next if tweet.users.include? user
          tweet.users << user
          tweet.save
          next
        end

        urls = []
        raw_urls.each do |url_addr|
          agent.get(url_addr)

          title = if /text\/html/ =~ agent.page.header['content-type']
                    agent.page.title
                  else
                    'no title'
                  end

          url = Url.new
          url.url = agent.page.uri.to_s
          url.title = title

          url.save
          urls << url
        end

        tweet = Tweet.new
        tweet[:id] = r.id
        tweet[:text] = r.text
        tweet[:retweeted] = r.retweeted
        tweet[:retweet_count] = r.retweet_count
        tweet[:favorited] = r.favorited
        tweet[:created_at] = r.created_at
        tweet.users << user
        tweet.urls << urls

        raw_user = r.user.to_hash
        twitter_user_id = raw_user['id']
        twitter_user = nil
        if TwitterUser.exists? twitter_user_id
          twitter_user = TwitterUser.find twitter_user_id
        else
          user_keys = TwitterUser.new.attributes.keys & raw_user.keys

          twitter_user_hash = {}
          user_keys.each do |key|
            twitter_user_hash[key] = raw_user[key]
          end

          twitter_user = TwitterUser.new(twitter_user_hash)
          twitter_user[:id] = twitter_user_id
          twitter_user[:created_at] = raw_user['created_at']
          twitter_user.save
        end

        tweet.twitter_user = twitter_user
        tweet.save
        return
      end
    end
  end
end

