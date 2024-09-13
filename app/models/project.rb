class Project < ApplicationRecord
  has_many :project_users, dependent: :destroy
  has_many :users, through: :project_users
  has_many :comments

  enum :status,
    {
      planned: "planned",
      started: "started",
      paused: "paused",
      review: "review",
      completed: "completed",
      canceled: "canceled"
    },
    default: :planned,
    validate: true
end
