class ArtworkComment < ApplicationRecord
  belongs_to :user
  belongs_to :artwork

  validates :user, presence: true
  validates :artwork, presence: true
  validates :body, presence: true
end
