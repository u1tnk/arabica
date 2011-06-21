require 'twitter'
require 'json'
require 'uri'
require 'net/http'

JSON.parse(Twitter.public_timeline).each do |tweet|
  uris = URI.extract(tweet['text'],  ['http', 'https'])
  unless uris.empty?
    uri = URI.parse(uris[0])
    tmp = Net::HTTP.new(uri.host).head(uri.path)['location']
    if tmp
      uri = tmp
    end

    puts "#{tweet['user']['name']} : #{uri}"
  end

end
