class FeedsController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json { render json: feeds_desc }
    end
  end

  def artworks
    @artworks = policy_scope(Artwork)
      .feed_for(current_user)
  end

  def scraps
    @scraps = policy_scope(Scrap)
      .feed_for(current_user)
  end

  def artwork_reblogs
    @artwork_reblogs = policy_scope(ArtworkReblog)
      .feed_for(current_user)
  end

  protected
  
  def feeds_desc
    {
      artworks: {
        url: "/feeds/artworks",
        type: "artwork",
      },
      scraps: {
        url: "/feeds/scraps",
        type: "scrap",
      }
    }
  end
end
