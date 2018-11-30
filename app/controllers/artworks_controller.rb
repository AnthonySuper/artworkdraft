class ArtworksController < ApplicationController

  def index
    @artworks = policy_scope(Artwork)
      .includes(user: {avatar_attachment: :blob})
      .with_attached_image
      .order(created_at: :desc)
    authorize @artworks
  end


  def show
    @artwork = Artwork.find(params[:id])
    authorize @artwork
  end

  def new
    @artwork = Artwork.new
    authorize @artwork
  end


  def create
    @artwork = Artwork.new(artwork_create_params)
    authorize @artwork
    respond_to do |format|
      if @artwork.save
        format.html { redirect_to @artwork }
        format.json { render @artwork }
      else
        format.html { render 'new' }
        format.json { render @artwork.errors }
      end
    end
  end

  protected
  def artwork_create_params
    params.require(:artwork).permit(:image, :name, :description)
      .merge(user: current_user)
  end
end
