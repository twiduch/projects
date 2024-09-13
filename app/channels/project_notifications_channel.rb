class ProjectNotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notifications_#{params[:project_id]}"
  end
end
