class AuthorizedController < ApplicationController
  before_filter :require_login
 
  private
 
  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to "/auth/twitter"
    end
  end

end
