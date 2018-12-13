module UsersHelper
  def action_class act
    return "" if is_artwork_reblog_hack?
    if params[:action].to_s == act.to_s
      "is-active"
    else
      ""
    end
  end

  def artwork_reblog_class
    if params[:action].to_s == "artwork_reblogs" || is_artwork_reblog_hack?
      return "is-active"
    else
      return ""
    end
  end

  def is_artwork_reblog_hack?
    params[:controller].to_s == "artwork_reblogs"
  end

end
