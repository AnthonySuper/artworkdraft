class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  
  def index?
    true
  end

  def show?
    true
  end

  def feed?
    show?
  end

  def artworks?
    show?
  end

  def unsubscribe?
    true
  end

  def scraps?
    show?
  end

  def artwork_reblogs?
    show?
  end

  def create?
    ! logged_in?
  end

  def destroy?
    same_user?
  end

  def verify_email?
    true
  end

  def update?
    same_user?
  end

  def followers?
    true
  end

  def mutuals?
    same_user?
  end

  protected

  def same_user?
    @user.user == @record
  end
end
