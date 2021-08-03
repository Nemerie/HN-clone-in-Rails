class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :votes

  before_save :downcase_email

  has_secure_password

	validates :name, presence: true,
                   uniqueness: true,
                   length: { maximum: 25 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true

  validates :password, presence: true, length: { minimum: 6 }

  def upvote(votable)
    votes.create(upvote: 1, votable_type: votable[:type], votable_id: votable[:id])
  end

  def upvoted?(votable)
    votes.exists?(upvote: 1, votable_type: votable[:type], votable_id: votable[:id])
  end
  
  def remove_vote(votable)
    votes.find_by(votable_type: votable[:type], votable_id: votable[:id]).destroy
  end

  private
    def downcase_email
      self.email = email.downcase
    end
end
