class ArtworkReblogPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.with_artworks(ArtworkPolicy::Scope.new(@user, Artwork.all).resolve)
    end
  end

  def create?
    logged_in?
  end
end
