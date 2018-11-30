class TagPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    logged_in?
  end

  def edit?
    logged_in?
  end

  def show?
    true
  end

  def index?
    true
  end
end
