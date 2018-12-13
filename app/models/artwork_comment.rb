class ArtworkComment < ApplicationRecord
  belongs_to :user
  belongs_to :artwork

  validates :user, presence: true
  validates :artwork, presence: true
  validates :body, presence: true

  after_create :notify_users

  def commented_id
    artwork.id
  end

  def commented_type
    :artwork
  end

  def commented_user
    artwork.user
  end

  def notify_users
    CommentedNotifier.new(self).notify!
  end
end
