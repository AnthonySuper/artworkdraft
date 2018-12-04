class ScrapsController < ApplicationController
  before_action :set_scrap,
    only: [:show, :edit, :update, :destroy]


  def index
    @scraps = policy_scope(Scrap)
      .includes(image_attachment: :blob)
      .search(params[:search])
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
  end

  def edit
  end

  def update
    respond_to do |format|
      if @scrap.update(scrap_params)
        format.html { redirect_to @scrap }
        format.json { render @scrap }
      else
        format.html { render "new", status: 401 }
        format.json { render @scrap.errors, status: 401 }
      end
    end
  end


  protected

  def scrap_params
    params
      .require(:scrap)
      .permit(:image, :name, :description, :nsfw, tag_ids: [])
      .merge(user: current_user)
  end

  def set_scrap
    @scrap = Scrap.find(params[:id])
    authorize @scrap
  end

end
