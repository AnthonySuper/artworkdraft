class Following < ApplicationRecord
  belongs_to :followee, class_name: "User"
  belongs_to :follower, class_name: "User"

  validates :followee, presence: true
  validates :follower, presence: true
end
