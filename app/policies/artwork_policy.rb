class ArtworkPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.with_nsfw(@user.prefs["nsfw"])
    end
  end

  def create?
    logged_in?
  end

  def index?
    true
  end

  def show?
    true
  end

  def update?
    owned?
  end

  def owned?
    @record.user == @user.user
  end
end
