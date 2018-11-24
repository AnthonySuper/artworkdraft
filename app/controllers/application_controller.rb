class ApplicationController < ActionController::Base

  include Pundit

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  helper_method :current_user
end
