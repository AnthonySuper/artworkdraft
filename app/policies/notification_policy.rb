class NotificationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    owned?
  end

  def update?
    owned?
  end

  def destroy?
    owned?
  end

  def index?
    logged_in?
  end

  protected

  def owned?
    @user.user == @record.user
  end
end
