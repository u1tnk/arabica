class TimeLineController < AuthorizedController
  def index
    screen_name =  params[:screen_name]
    unless screen_name
      screen_name = current_user.screen_name
      # 初回アクセス時は現在のtime_lineから50件取り込む、最大200件可能だが、時間がかかるため
      unless current_user.tweets.exists?
        current_user.collect_urls
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
        users.provider = 'twitter'
        and users.uid = ?
    ";
    @urls = Url.find_by_sql [sql, @user.uid]
  end
end
