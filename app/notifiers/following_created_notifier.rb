class FollowingCreatedNotifier < ApplicationNotifier
  
  def initialize following
    @following = following
  end

  def type
    "USER_FOLLOWED"
  end

  def data
    {
      follower_name: @following.follower.name,
      follower_id: @following.follower.id
    }
  end
    
  def notified_users 
    [@following.followee]
  end

  def should_email? user
    user.notification_email_prefs.user_followed
  end

  def email_action
    :user_followed
  end
end
