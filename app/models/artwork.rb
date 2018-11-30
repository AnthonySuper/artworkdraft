class Artwork < ApplicationRecord

  # CONCERNS
  include Worksafe

  # RELATIONS
  belongs_to :user

  has_many :comments, class_name: "ArtworkComment"
  # ATTACHMENTS
  has_one_attached :image

  # VALIDATIONS
  validates :user, presence: true
  validates :name, presence: true
end
