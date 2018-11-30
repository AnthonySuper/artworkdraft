class Tag < ApplicationRecord


  # RELATIONS
  has_many :artwork_tags

  has_many :artworks, through: :artwork_tags

  has_many :scrap_tags

  has_many :scraps, through: :scrap_tags

  # VALIDATIONS
  validates :name, presence: true

end
