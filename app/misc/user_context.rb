class UserContext
  attr_reader :user

  def initialize(user, prefs)
    @user, @prefs = user, prefs
  end


  def prefs
    user_prefs.merge(prefs)
  end

  def user_prefs
    if @user
      @user.prefs
    else
      {}
    end
  end

end
