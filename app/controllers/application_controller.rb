class ApplicationController < ActionController::Base

  include Pundit

  def paginate collection
    c = if params["page_after"]
      collection.page_after(to_time(params["page_after"]))
    else
      collection
    end
    c.limit(per_page)
  end

  def per_page
    params["per_page"].try(:to_i) || 20
  end


  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def pundit_user
    @pundit_user ||= UserContext.new(current_user, user_prefs)
  end

  def user_prefs
    (session[:prefs] || {}).merge(params.permit(prefs: {})[:prefs] || {})
  end

  protected

  def to_time time
    Time.at(time.to_f)
  end

  helper_method :current_user
end
