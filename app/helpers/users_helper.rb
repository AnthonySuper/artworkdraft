module UsersHelper
  def action_class act
    if params[:action].to_s == act.to_s
      "is-active"
    else
      ""
    end
  end

end
