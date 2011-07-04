class TimeLineController < AuthorizedController
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
    @user = current_user
    sql = "
      select distinct 
        urls.*
      from 
        urls 
        inner join tweets_urls on urls.id = tweets_urls.url_id 
        inner join tweets_users on tweets_urls.tweet_id = tweets_users.tweet_id 
        inner join users on users.id = tweets_users.user_id 
      where
        users.id = ?
    ";
    @urls = Url.find_by_sql [sql, @user.id]
    return
    @urls = Url.join("tweets_users").limit(5)
    p "aa"
    p @urls.size
    p "aa"
  end
end
