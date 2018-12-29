class User < ApplicationRecord
  include Paginated

  has_secure_password

  has_many :scraps

  has_many :scrap_comments

  has_many :artworks

  has_many :followee_followings,
    class_name: "Following",
    foreign_key: :followee_id
  has_many :users_following,
    through: :followee_followings,
    class_name: "User",
    source: :follower

  has_many :follower_followings,
    class_name: "Following",
    foreign_key: :follower_id

  has_many :users_followed,
    through: :follower_followings,
    class_name: "User",
    source: :followee 

  has_many :notifications

  # ATTACHMENTS
  has_one_attached :avatar

  # METAPROGRAMMING WEIRDNESS

  class NotificationPrefs
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :user_followed, :boolean
    attribute :user_commented, :boolean
    attribute :user_reblogged, :boolean

    def to_json
      attributes.to_json
    end

    class Type < ActiveRecord::Type::Value
      def type
        :jsonb
      end

      def cast value
        NotificationPrefs.new(value)
      end

      def deserialize value
        if String === value
          decoded = ::ActiveSupport::JSON.decode(value) rescue nil
          NotificationPrefs.new(decoded)
        else
          super
        end
      end

      def serialize value
        case value
        when Array, Hash
          ::ActiveSupport::JSON.encode(value)
        when NotificationPrefs
          value.to_json
        else
          super
        end
      end
    end
  end

  attribute :notification_email_prefs, NotificationPrefs::Type.new


  # TOKENS
  has_secure_token :email_confirmation_token
  has_secure_token :unsubscribe_token

  # VALIDATIONS
  validates :name, presence: true
  validates :email, presence: true

  # HOOKS
  after_create :verify_email!

  def unsubscribe_from_everything!
    attrs = notification_email_prefs.attributes.map do |k, v|
      [k, false]
    end
    regenerate_unsubscribe_token
    update(notification_email_prefs: Hash[attrs])
  end


  def mutuals
    User.where(id: users_following).where(id: users_followed)
  end

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
