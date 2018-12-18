class Notification < ApplicationRecord
  include Paginated

  belongs_to :user

  validates :user, presence: true
  validates :payload, presence: true

  # SCOPES
  def self.unread
    where(read: false)
  end

end
