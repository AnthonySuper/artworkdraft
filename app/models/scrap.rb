class Scrap < ApplicationRecord

  # CONCERNS
  include Worksafe

  # RELATIONS 
  belongs_to :user


  has_many :comments,
    class_name: "ScrapComment"


  # ATTACHMENTS 
  has_one_attached :image

  # VALIDATIONS
  validates :user, presence: true

end
