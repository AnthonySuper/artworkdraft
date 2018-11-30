class ScrapTag < ApplicationRecord
  belongs_to :tag
  belongs_to :scrap

  validates :tag, presence: true
  validates :scrap, presence: true

end
