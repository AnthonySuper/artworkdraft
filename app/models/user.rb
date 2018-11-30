class User < ApplicationRecord
  has_secure_password

  has_many :scraps

  has_many :scrap_comments

  has_many :artworks


  has_one_attached :avatar


  validates :name, presence: true
  validates :email, presence: true


  def avatar_img
    return avatar.variant(resize: "128x128>") if avatar.attachment
    "default_square.png"
  end

  def small_avatar_img
    return avatar&.variant(resize: "64x64>") if avatar.attachment
    "default_square.png"
  end
end
