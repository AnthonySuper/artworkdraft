class User < ApplicationRecord
  include Paginated

  has_secure_password

  has_many :scraps

  has_many :scrap_comments

  has_many :artworks

  has_many :followee_fallowings,
    class_name: "Following",
    foreign_key: :followee_id
  has_many :users_following,
    through: :followee_fallowings,
    class_name: "User",
    source: :follower

  has_many :follower_fallowings,
    class_name: "Following",
    foreign_key: :follower_id
  has_many :users_followed,
    through: :follower_fallowings,
    class_name: "User",
    source: :followee 

  # ATTACHMENTS
  has_one_attached :avatar

  # TOKENS
  has_secure_token :email_confirmation_token

  # VALIDATIONS
  validates :name, presence: true
  validates :email, presence: true

  # HOOKS
  after_create :verify_email!

  def followed_by? user
    users_following.include? user
  end

  def following? user
    users_followed.include? user
  end

  def followable_by? user
    ! user.nil? && ! followed_by?(user)
  end

  def unfollowable_by? user
    ! user.nil? && followed_by?(user)
  end

  def avatar_img
    return avatar.variant(resize: "128x128>") if avatar.attachment
    "default_square.png"
  end

  def small_avatar_img
    return avatar&.variant(resize: "64x64>") if avatar.attachment
    "default_square.png"
  end

  def verify_email!(later = true)
    t = EmailValidatorMailer.with(user: self).verify_email
    if later
      t.deliver_later
    else
      t.deliver_now
    end
  end
end
