class ProjectsController < ApplicationController
  before_action :authenticate_request
  before_action :set_project, only: %i[show status_change]

  def index
    @projects = current_user.projects
  end

  def show
    @comments = @project.comments.order(created_at: :desc)
  end


  private


  def set_project
    @project = current_user.projects.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "We couldn't find this project. Let's see all of them."
    redirect_to projects_path
  end
end
