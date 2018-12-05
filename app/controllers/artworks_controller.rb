class ArtworksController < ApplicationController
  before_action :set_artwork,
    only: [:show, :update, :edit, :destroy]

  def index
    @artworks = policy_scope(Artwork)
      .includes(user: {avatar_attachment: :blob})
      .with_attached_image
      .order(created_at: :desc)
      .search(params[:search])
    authorize @artworks
  end


  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @artwork.update(artwork_create_params)
        format.html { redirect_to @artwork }
        format.json { render @artwork }
      else
        format.html { render 'edit', status: 422 }
        format.json { render @artwork.errors, status: 422 }
      end
    end
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

  def destroy
    respond_to do |format|
      if @artwork.destroy
        format.html { redirect_to artworks_path }
      else
        format.html { redirect_to @artwork }
      end
    end
  end


  protected
  def artwork_create_params
    params.require(:artwork)
      .permit(:image, :name, :description, :nsfw, tag_ids: [])
      .merge(user: current_user)
  end
  
  def set_artwork
    @artwork = Artwork.find(params[:id])
    authorize @artwork
  end
end
