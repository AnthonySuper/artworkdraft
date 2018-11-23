class User < ApplicationRecord
  has_secure_password

  has_many :scraps

  has_many :scrap_comments


  validates :name, presence: true
  validates :email, presence: true
end
