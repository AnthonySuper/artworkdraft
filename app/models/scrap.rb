class Scrap < ApplicationRecord

  # CONCERNS
  include Worksafe
  include TagSearched
  include Searched
  include Feeded
  include Paginated

  # RELATIONS 
  belongs_to :user


  has_many :comments,
    class_name: "ScrapComment"

  has_many :scrap_tags
  has_many :tags, through: :scrap_tags

  # ATTACHMENTS 
  has_one_attached :image

  # VALIDATIONS
  validates :user, presence: true

  validates :image, attached: true


  # SCOPES
  def self.made_by users
    joins(:user).where(user: users)
  end

  # METHODS
  def thumbnail_path
    return image.variant(resize: "500x500>") if image.attachment
    "default_square.png"
  end

end
