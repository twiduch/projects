class User < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { minimum: 3, message: "must be at least 3 characters long" }
end
