class ArtworksController < ApplicationController
  def show
    @artwork = Artwork.find(params[:id])
    authorize @artwork
  end
end
