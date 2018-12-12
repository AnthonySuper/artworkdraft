class Notification < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :payload, presence: true
end
