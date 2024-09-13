class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :content, presence: true, length: { maximum: 500 }
  validate :content_must_have_non_whitespace_characters

  after_create_commit do
    broadcast_prepend_to "notifications_#{project_id}", target: "project-conversation", formats: [ :turbo_stream ]
  end

  def author_name
    user&.name
  end

  private

  def content_must_have_non_whitespace_characters
    if content.strip.empty?
      errors.add(:content, "must contain non-whitespace characters")
    end
  end
end
