class User < ApplicationRecord
  has_secure_password

  has_many :scraps

  has_many :scrap_comments

  has_many :artworks

  has_many :followings_followee,
    class_name: "Following",
    foreign_key: :follower_id
  has_many :users_followed,
    through: :followings_followee,
    foreign_key: :followee_id,
    class_name: "User"

  has_many :followings_follower,
    class_name: "Following",
    foreign_key: :followee_id
  has_many :users_following,
    through: :followings_follower,
    foreign_key: :follower_id,
    class_name: "User"


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
