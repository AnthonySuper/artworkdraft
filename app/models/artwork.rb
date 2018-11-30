class Artwork < ApplicationRecord

  # RELATIONS
  belongs_to :user


  # ATTACHMENTS
  has_one_attached :image

  # VALIDATIONS
  validates :user, presence: true
  validates :name, presence: true
end
