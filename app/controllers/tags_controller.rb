class TagsController < ApplicationController

  def index
    @tags = policy_scope(Tag).all
    authorize @tags
  end

  def show
    @tag = Tag.find(params[:id])
    authorize @tag
  end

  def new
    @tag = Tag.new
    authorize @tag
  end

  def create
    @tag = Tag.new(tag_params)
    authorize @tag
    respond_to do |format|
      if @tag.save 
        format.html { redirect_to @tag }
        format.json { render @tag }
      else
        format.html { render 'new' }
        format.json { render @tag.errors, status: 402 } 
      end
    end
  end



  def tag_params
    params.require(:tag).permit(:name, :description, :nsfw)
  end
end
