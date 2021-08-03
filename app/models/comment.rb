class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :comment, optional: true

  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :content, presence: true, length: { maximum: 1000 }

  has_many :comments
  has_many :votes, as: :votable

  def votes_count
    votes.length
  end
end
