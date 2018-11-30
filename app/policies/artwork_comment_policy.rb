class ArtworkCommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    logged_in?
  end

  def show?
    true
  end

  def update?
    @record.user == @user.user
  end

  def destroy?
    @record.user == @user.user
  end
end
