class TimeLineController < ApplicationController
  def index
    name =  params[:name]
    unless name
      name = current_user.login
      # 初回アクセス時は現在のtime_lineから200件取り込む
      unless current_user.tweets.exists?
        @client = twitter_client
        raw_tweets = @client.home_timeline(:count => 200)
        Url.filter_urls_from_tweets current_user, raw_tweets
      end

      @user = current_user
      @urls = []
      # ,@urls = Url.filter_urls_from_tweets(@user, @user.tweets)
    end
  end

end
