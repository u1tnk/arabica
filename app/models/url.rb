require 'uri'
require 'net/http'

class Url < ActiveRecord::Base
  has_and_belongs_to_many :tweets

  class << self
    def filter_urls_from_tweets
      Tweet.all.each do |tweet|
        urls = URI.extract(tweet.text,   ['http', 'https'])
        unless urls.empty?
          tmp = Net::HTTP.get_response(URI.parse(urls[0]))

          url = Url.new
          url.url = tmp.key?('location') ? tmp['location'] : urls[0]
          url.title = 'hoge' # tmp.body.scan(/<title>(.*)<\/title>/)
          url.save
          url.tweets << tweet
        end
      end
    end
  end
end

