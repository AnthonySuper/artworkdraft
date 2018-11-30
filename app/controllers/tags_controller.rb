class TagsController < ApplicationController

  def index
    @tags = policy_scope(Tag).all
    authorize @tags
  end

  def show
    @tag = Tag.find(params[:id])
  end


  def tag_params
    params.require(:tag).permit(:name, :description)
  end
end
