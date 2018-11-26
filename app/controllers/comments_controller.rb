class CommentsController < ApplicationController
  before_action :set_commentable

  def create
    @comment = @commentable.comments.new(comment_params)
    authorize @comment
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @commentable }
        format.json { render @comment }
      else
        format.html { redirect_to @commentable }
        format.json { render @comment.errors }
      end
    end
  end

  def comment_params
    params
      .require(:comment)
      .permit(:body)
      .merge(user: current_user)
  end

  protected

  def set_commentable
    commentable_id = params["#{params[:commentable_type].underscore}_id"]
    type = params[:commentable_type].constantize
    @commentable = policy_scope(type).find(commentable_id)
    authorize @commentable
  end
end
