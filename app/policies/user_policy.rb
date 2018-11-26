class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    ! logged_in?
  end

  def destroy?
    same_user?
  end

  def update?
    same_user?
  end

  protected

  def same_user?
    @user == @record
  end
end
