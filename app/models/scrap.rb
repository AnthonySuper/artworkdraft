class Scrap < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  has_many :comments,
    class_name: "ScrapComment"

  validates :user, presence: true
end
