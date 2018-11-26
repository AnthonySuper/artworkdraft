class ScrapsController < ApplicationController


  def index
    @scraps = policy_scope(Scrap)
      .includes(image_attachment: :blob)
  end
  
  def new
    @scrap = Scrap.new
    authorize @scrap
  end

  def create
    @scrap = Scrap.new(scrap_params)
    authorize @scrap
    respond_to do |format|
      if @scrap.save
        format.html { redirect_to @scrap }
        format.json { render @scrap }
      else
        format.html { render 'new' }
        format.json { render @scrap.errors }
      end
    end
  end

  def show
    @scrap = Scrap.find(params[:id])
    authorize @scrap
  end


  protected

  def scrap_params
    params
      .require(:scrap)
      .permit(:image, :name, :description, :nsfw)
      .merge(user: current_user)
  end
end
