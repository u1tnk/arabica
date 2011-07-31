# -*- coding:utf-8 -*-
class SessionsController < ApplicationController
  def callback
    begin
    auth = request.env['omniauth.auth']
    user = User.find_by_provider_and_uid(auth['provider'], auth['uid']) || User.create_with_omniauth(auth)

    session[:user_id] = user.id
    redirect_to root_url, :notice => "ログインしました"
    rescue => e
      p e
    end

  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "ログアウトしました"
  end

  def failure
  end
end
