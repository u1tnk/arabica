class TimeLineController < ApplicationController
  def index
    name =  params[:name]
    unless name
      name = current_user.login
      # 初回アクセス時は現在のtime_lineから200件取り込む
      unless current_user.tweets.exists?
        @client = twitter_client
        @client.home_timeline(:count => 200).each do |r|
          tweet = Tweet.new
          #TODO 既存のtweetのときは追加せず、usersのみ増やす

          tweet[:id] = r.id
          tweet[:text] = r.text
          tweet[:retweeted] = r.retweeted
          tweet[:retweet_count] = r.retweet_count
          tweet[:favorited] = r.favorited
          tweet[:created_at] = r.created_at
          tweet.users << current_user

          #TODO 既存のtwitter_userのときは追加せず参照のみ更新
          user = r.user.to_hash
          user.delete 'id_str'
          user.delete 'is_translator'
          user.delete 'profile_background_image_url_https'
          user.delete 'profile_image_url_https'
          tweet.twitter_user = TwitterUser.new(user)

          tweet.save
        end
      end
    end

  end

end
