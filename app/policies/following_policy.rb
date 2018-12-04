class FollowingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    logged_in? && is_follower?
  end

  def destroy?
    logged_in? && is_follower?
  end

  protected
  def is_follower?
    @record.follower == @user.user
  end
end
