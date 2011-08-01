class User < ActiveRecord::Base
  has_many :tweets_users
  has_many :tweets, :through => :tweets_users
  has_many :tweets_urls, :through => :tweets
  has_many :urls, :through => :tweets_urls

  def self.create_with_omniauth(auth)
    create! do |user|
      auth_user = auth['extra']["user_hash"]
      token = auth['extra']['access_token']

      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth_user['name']
      user.screen_name = auth_user['screen_name']
      user.profile_image_url = auth_user['profile_image_url']
      user.access_token = token.token
      user.access_secret = token.secret
    end
  end
  def twitter_client
    @client = Twitter::Client.new(
      :format => "json", 
      :consumer_key => ENV['ARABICA_CONSUMER'] , 
      :consumer_secret => ENV['ARABICA_CONSUMER_SECRET'], 
      :oauth_token => access_token, 
      :oauth_token_secret => access_secret
    )
  end

  def collect_urls args = {}
    param = {:max => 50}
    param.merge! args

    raw_tweets = twitter_client.home_timeline(:count => param[:max])
    collect_urls_from_tweets raw_tweets
  end
  def collect_urls_from_tweets raw_tweets
    agent = Mechanize.new

    raw_tweets.each do |r|

      raw_urls = URI.extract(r.text, ['http', 'https'])
      next if raw_urls.empty?
      if Tweet.exists? r.id
        tweet = Tweet.find r.id
        next if tweet.users.include? self
        tweet.users << self
        tweet.save
        next
      end

      urls = []
      raw_urls.each do |url_addr|
        begin
          agent.get(url_addr)
          title = nil
          if /text\/html/ =~ agent.page.header['content-type']
            title = agent.page.title
            #p "canonival"
            #p agent.at("link[@rel='canonical']")
          else
            title = 'no title'
          end
          url = Url.where(:url => agent.page.uri.to_s)
          if url.empty?
            url = Url.new
            url.url = agent.page.uri.to_s
            url.title = title

            url.save
          end
          urls << url
        rescue => e
          # 404をスルー
          logger.debug e
        end
      end

      tweet = Tweet.new
      tweet[:id] = r.id
      tweet[:text] = r.text
      tweet[:retweeted] = r.retweeted
      tweet[:retweet_count] = r.retweet_count
      tweet[:favorited] = r.favorited
      tweet[:created_at] = r.created_at
      tweet.users << self
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
    end
  end
end
