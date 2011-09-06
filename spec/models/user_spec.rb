# coding: utf-8
require 'spec_helper'
require 'ostruct'

describe User do
  before do
    entities = OpenStruct.new(
      :hashtags=>[OpenStruct.new(:indices=>[104, 118],:text=>"theinterviews")],
      :urls =>[OpenStruct.new(
            :display_url=>"theinterviews.jp/takai/54689",
            :expanded_url=>"http://theinterviews.jp/takai/54689",
            :indices=>[119, 138],
            :url=>"http://t.co/43wJ7tY"
          )
        ]
    )

    @user_id = 2799501
    user=OpenStruct.new(:id=>@user_id,:id_str=>@user_id.to_s)

    @id = 109861663192252416
    @raw_tweets = [OpenStruct.new(
      :contributors=>nil, 
      :coordinates=>nil,
      :created_at=>"Sat Sep 03 05:33:56 +0000 2011",
      :entities=>entities,
      :user_mentions=>[],
      :favorited=>false, 
      :geo=>nil, 
      :id=>@id, 
      :id_str=>"109861663192252416", 
      :in_reply_to_screen_name=>nil, 
      :in_reply_to_status_id=>nil, 
      :in_reply_to_status_id_str=>nil, 
      :in_reply_to_user_id=>nil, 
      :in_reply_to_user_id_str=>nil,
      :place=>nil, 
      :possibly_sensitive=>false, 
      :retweet_count=>0, 
      :retweeted=>false, 
      :source=>"<a href=\"http://twitter.com/tweetbutton\" rel=\"nofollow\">Tweet Button</a>", 
      :text=>"ネタかと思ったけどだいたいあってる / Rubyist写真家の頂点を極めた高井さんに質問です。Rubyistのリアルな生態をとらえる技・心構えをズバリ教えてください。 - 高井 直人 [ザ・インタビューズ] #theinterviews http://t.co/43wJ7tY", 
      :truncated=>false, 
      :user=>user
    )]

    @twitter_user = TwitterUser.new
    @twitter_user.id = @user_id
    @twitter_user.save
  end

  it "仕様化テスト" do
    data = {
      :provider => :twitter,
      :uid => @user_id,
      :screen_name => :screen_name,
      :name => :name,
      :profile_image_url => :profile_image_url,
      :access_secret => :access_secret,
      :access_token => :access_token
    }

    @user = User.new(data)
    @user.collect_urls_from_tweets(@raw_tweets)
    Tweet.all.should have(1).items
  end

  after do
    User.delete_all
    Url.delete_all
    Tweet.delete_all
    TweetsUrl.delete_all
    TweetsUser.delete_all
    TwitterUser.delete_all
  end
end

