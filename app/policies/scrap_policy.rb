class ScrapPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def create?
    logged_in?
  end

  def show?
    true
  end

  def update?
    owned?
  end

  def destroy?
    owned?
  end

  protected
  def owned?
    @record.user == @user
  end
end
