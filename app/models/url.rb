require 'uri'
require 'mechanize'

class Url < ActiveRecord::Base
  has_and_belongs_to_many :tweets

  class << self
    def filter_urls_from_tweets
      agent = Mechanize.new

      Tweet.all.each do |tweet|
        urls = URI.extract(tweet.text,   ['http', 'https'])

        urls.each do |url_addr|
          agent.get(url_addr)

          title = if agent.page.header['content-type'] == 'text/html'
                    agent.page.title
                  else
                    'no title'
                  end

          url = Url.new
          url.url = agent.page.uri
          url.title = title
          url.tweets << tweet

          url.save
        end
      end
    end
  end
end

