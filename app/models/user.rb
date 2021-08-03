class User < ApplicationRecord
  has_many :posts
  has_many :comments

  has_secure_password

	validates :name, presence: true,
                   uniqueness: true,
                   length: { maximum: 25 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true

  validates :password, presence: true, length: { minimum: 6 }
end
