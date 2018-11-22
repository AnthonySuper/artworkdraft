class Scrap < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  validates :user, presence: true
end
