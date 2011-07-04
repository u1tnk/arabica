class HomeController < ApplicationController
  def index
    User.new.delay.hello
  end
end
