class TagPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.with_nsfw(@user.prefs["nsfw"])
    end
  end

  def create?
    logged_in?
  end

  def update?
    logged_in?
  end

  def show?
    true
  end

  def index?
    true
  end
end
