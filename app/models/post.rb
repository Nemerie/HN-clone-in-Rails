class Post < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 100 }
  validates :url, presence: true

  has_many :comments

  def comment_count
    comments.length
  end
end
