class ScrapPolicy < ApplicationPolicy
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
end
