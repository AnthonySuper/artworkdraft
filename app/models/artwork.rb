class Artwork < ApplicationRecord

  # CONCERNS
  include Worksafe
  include TagSearched
  include Searched
  include Feeded
  include Paginated

  # RELATIONS
  belongs_to :user

  has_many :comments, class_name: "ArtworkComment"

  has_many :artwork_tags

  has_many :tags, through: :artwork_tags
  # ATTACHMENTS
  has_one_attached :image

  # VALIDATIONS
  validates :user, presence: true
  validates :name, presence: true
  validates :image, attached: true

  # SCOPES
  def self.made_by users
    joins(:user).where(user: users)
  end
end
