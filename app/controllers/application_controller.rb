class ApplicationController < ActionController::Base
  protect_from_forgery
  def twitter_client
    if current_user 
      @client = Twitter::Client.new(
        :format => "json", 
        :consumer_key => TwitterAuth.config['oauth_consumer_key'] , 
        :consumer_secret => TwitterAuth.config['oauth_consumer_secret'], 
        :oauth_token => current_user.access_token, 
        :oauth_token_secret => current_user.access_secret)
    end
  end
end
