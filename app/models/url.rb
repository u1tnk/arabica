require 'uri'
require 'mechanize'

class Url < ActiveRecord::Base
  has_and_belongs_to_many :tweets

  class << self
    def filter_urls_from_tweets user, raw_tweets
      agent = Mechanize.new

      raw_tweets.each do |r|
        raw_urls = URI.extract(r.text, ['http', 'https'])

        urls = []
        raw_urls.each do |url_addr|
          agent.get(url_addr)

          title = if agent.page.header['content-type'] == 'text/html'
                    agent.page.title
                  else
                    'no title'
                  end

          url = Url.new
          url.url = agent.page.uri
          url.title = title

          url.save
          urls << url
        end
        #TODO 既存のtweetのときは追加せず、usersのみ増やす

        tweet = Tweet.new
        tweet[:id] = r.id
        tweet[:text] = r.text
        tweet[:retweeted] = r.retweeted
        tweet[:retweet_count] = r.retweet_count
        tweet[:favorited] = r.favorited
        tweet[:created_at] = r.created_at
        tweet.users << user
        tweet.urls << urls

        #TODO 既存のtwitter_userのときは追加せず参照のみ更新
        raw_user = r.user.to_hash
        user_keys = TwitterUser.new.attributes.keys & raw_user.keys
        twitter_user = {}
        user_keys.each do |key|
          twitter_user[key] = raw_user[key]
        end
        tweet.twitter_user = TwitterUser.new(twitter_user)

        tweet.save
      end
    end
  end
end

