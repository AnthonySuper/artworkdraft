class ReblogNotifier < ApplicationNotifier
  def initialize reblog
    @reblog = reblog
  end

  def type
    "USER_REBLOGGED"
  end

  def data
    {
      artwork_id: @reblog.root_artwork.id,
      reblogger_id: @reblog.user.id,
      reblogger_name: @reblog.user.name
    }
  end

  def notified_users
    # the last element is *this reblog* which we don't notify for
    arr = @reblog.ordered_ancestors.joins(:user).map(&:user).to_a[0..-2]
    arr.push(@reblog.root_artwork.user)
    User.where(id: arr.map(&:id)).to_a
  end

  def should_email? user
    user.notification_email_prefs.user_reblogged
  end

  def email_action
    :user_reblogged
  end
end
