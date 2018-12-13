class Following < ApplicationRecord
  belongs_to :followee, class_name: "User"
  belongs_to :follower, class_name: "User"

  validates :followee, presence: true,
    uniqueness: { scope: :follower_id } 
  validates :follower, presence: true,
    uniqueness: { scope: :followee_id }

  after_create :send_notifications!

  def send_notifications!
    FollowingCreatedNotifier.new(self).notify!
  end
end
