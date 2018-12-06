class ArtworkReblogsController < ApplicationController
  before_action :set_artwork_reblog,
    only: [:show, :destroy]

  def create
    @artwork_reblog = ArtworkReblog.new(artwork_reblog_params)
    authorize @artwork_reblog
    respond_to do |format|
      format.html
      format.json { render @artwork_reblog }
    end
  end

  def show
  end

  protected
  def artwork_reblog_params
    params.require(:artwork_reblog)
      .permit(:ancestor_id,
              :comment,
              :artwork_id)
      .merge(user: current_user)
  end

  def set_artwork_reblog
    @artwork_reblog = ArtworkReblog.find(params[:id])
  end
end
