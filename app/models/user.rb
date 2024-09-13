class User < ApplicationRecord
  has_many :project_users, dependent: :destroy
  has_many :projects, through: :project_users
  has_many :comments

  validates :name, presence: true
  validates :name, length: { minimum: 3, message: "must be at least 3 characters long" }
end
