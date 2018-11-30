class ArtworkTag < ApplicationRecord

  # RELATIONS
  belongs_to :artwork
  belongs_to :tag

  validates :tag, presence: true
  validates :artwork, presence: true
end
