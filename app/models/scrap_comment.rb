class ScrapComment < ApplicationRecord
  belongs_to :user
  belongs_to :scrap


  validates :user, presence: true
  validates :scrap, presence: true

  after_create :notify_users

  def commented_id
    scrap.id
  end

  def commented_type
    :scrap
  end

  def commented_user
    scrap.user
  end

  def notify_users
    CommentedNotifier.new(self).notify!
  end
end
