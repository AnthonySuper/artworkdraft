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

  def update?
    @user == @record
  end
end
