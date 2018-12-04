class FollowingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    is_follower?
  end

  def destroy?
    is_follower?
  end

  protected
  def is_follower?
    @record.follower == @user.user
  end
end
