module CommentsHelper
  def comment_author(comment)
    comment.author_name || "Unknown Author"
  end
end
