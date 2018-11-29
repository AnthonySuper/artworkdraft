class User < ApplicationRecord
  has_secure_password

  has_many :scraps

  has_many :scrap_comments

  has_many :artworks


  has_one_attached :avatar


  validates :name, presence: true
  validates :email, presence: true


  def avatar_img
    avatar.variant(resize: "128x128>")
  end
end
