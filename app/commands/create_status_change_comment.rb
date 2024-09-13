class CreateStatusChangeComment
  def initialize(project:, user:, status:)
    @project = project
    @user = user
    @status = status
  end

  def call
    create_comment
  rescue StandardError => e
    Rails.logger.error "Failed to create comment: #{e.message}"
    false
  end

  private

  def create_comment
    Comment.create!(
      content: "Project Status changed to #{@status}",
      user: @user,
      project: @project
    )
  end
end
