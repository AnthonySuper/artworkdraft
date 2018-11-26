class ApplicationController < ActionController::Base

  include Pundit

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def pundit_user
    @pundit_user ||= UserContext.new(current_user, user_prefs)
  end

  def user_prefs
    (session[:prefs] || {}).merge(params.permit(prefs: {})[:prefs] || {})
  end

  helper_method :current_user
end
