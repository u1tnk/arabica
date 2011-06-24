class TimeLineController < ApplicationController
  def index
    name =  params[:name]
    unless name
      name = current_user.login
      # 初回アクセス時は現在のtime_lineから50件取り込む、最大200件可能だが、時間がかかるため
      unless current_user.tweets.exists?
        @client = twitter_client
        raw_tweets = @client.home_timeline(:count => 50)
        Url.filter_urls_from_tweets current_user, raw_tweets
      end
    end

  end

end
