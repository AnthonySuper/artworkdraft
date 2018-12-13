class CommentedNotifier < ApplicationNotifier
  def initialize comment
    @comment = comment
  end

  def type
    "USER_COMMENTED"
  end

  def data
    {
      commenter_id: @comment.user.id,
      commenter_name: @comment.user.name,
      commented_id: @comment.commented_id,
      commented_type: @comment.commented_type.to_s
    }
  end

  def notified_users
    [@comment.commented_user]
  end

  def should_email? user
    user.notification_email_prefs.user_commented
  end

  def email_action
    :user_commented
  end
end
