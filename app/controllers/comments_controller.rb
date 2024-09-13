class CommentsController < ApplicationController
  before_action :authenticate_request

  def create
    project = current_user.projects.find(params[:project_id])
    @comment = project.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      head :created
    else
      redirect_to project_url(project), alert: "Comment could not be saved."
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
