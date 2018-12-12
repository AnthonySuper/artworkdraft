class FeedsController < ApplicationController
  before_action :set_user,
    if: :is_created?

  def index
    respond_to do |format|
      format.html
      format.json { render json: feeds_desc }
    end
  end

  def artworks
    @artworks = paginate(feeded(policy_scope(Artwork)))
    respond_to do |format|
      format.json
      format.html do
        if is_created?
          render "users/artworks"
        else
          head(:not_acceptable)
        end
      end
    end
  end

  def scraps
    @scraps = paginate(feeded(policy_scope(Scrap)))
    respond_to do |format|
      format.json
      format.html do
        if is_created?
          render "users/scraps"
        else
          head(:not_acceptable)
        end
      end
    end
  end

  def artwork_reblogs
    @artwork_reblogs = paginate(feeded(policy_scope(ArtworkReblog)));
  end

  protected

  def is_created?
    params["feed_type"].to_s == "created"
  end

  def feeded collection
    if is_created?
      collection.created_feed_for(@user)
    else
      collection.feed_for(current_user)
    end
  end
  
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

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end
end
