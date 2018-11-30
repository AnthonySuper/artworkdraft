module CommentsHelper
  def new_comment_path(commentable)
    case commentable
    when Scrap
      scrap_comments_path(commentable)
    when Artwork
      artwork_comments_path(commentable)
    else
      raise "Don't know what the comment path for #{commentable.class} is"
    end
  end
end
