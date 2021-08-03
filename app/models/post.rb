class Post < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true

  has_many :comments

  def comment_count
    comments.length
  end
end
