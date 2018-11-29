class Artwork < ApplicationRecord

  # RELATIONS
  belongs_to :user

  # VALIDATIONS
  validates :user, presence: true
  validates :name, presence: true
end
