class Tag < ApplicationRecord


  # RELATIONS
  has_many :artwork_tags

  has_many :artworks, through: :artwork_tags

  validates :name, presence: true

end
