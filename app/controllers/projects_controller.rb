class ProjectsController < ApplicationController
  before_action :authenticate_request
  before_action :set_project, only: %i[show status_change]

  def index
    @projects = current_user.projects
  end

  def show
    @comments = @project.comments.order(created_at: :desc)
  end

  def status_change
    status = params[:status]

    if @project.update(status: status) && create_status_change_comment(status)
        head :no_content
    else
      flash[:alert] = "Failed to update project status or create a comment."
      head :internal_server_error
    end
  end

  private

  def create_status_change_comment(status)
    CreateStatusChangeComment.new(project: @project, user: current_user, status: status).call
  end

  def set_project
    @project = current_user.projects.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "We couldn't find this project. Let's see all of them."
    redirect_to projects_path
  end
end
