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
    @urls = current_user.urls
  end
end
