class NilClassPolicy < ApplicationPolicy
  def destroy?
    false
  end

  def new?
    false
  end

  def create?
    false
  end

  def show?
    false
  end

  def index?
    false
  end

  def edit?
    false
  end

  def update?
    false
  end


  class Scope < ApplicationPolicy::Scope
    def resolve
      []
    end
  end
end
