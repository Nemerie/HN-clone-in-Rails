# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 100 }
  validates :url, presence: true

  has_many :comments
  has_many :votes, as: :votable

  def votes_count
    votes.length + points
  end

  def comment_count
    comments.length
  end
end
