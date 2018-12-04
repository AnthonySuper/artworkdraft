class HomeController < ApplicationController
  def index
    if current_user
      render "feeds/index"
    else
      render "index"
    end
  end
end
