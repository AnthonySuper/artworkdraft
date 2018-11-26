class Scrap < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  has_many :comments,
    class_name: "ScrapComment"

  validates :user, presence: true

  def self.with_nsfw nsfw
    case nsfw
    when "required"
      where(nsfw: true)
    when "allowed", true
      all
    else
      where(nsfw: false)
    end
  end
end
