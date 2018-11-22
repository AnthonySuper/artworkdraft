class ScrapComment < ApplicationRecord
  belongs_to :user
  belongs_to :scrap


  validates :user, presence: true
  validates :scrap, presence: true

end
