# frozen_string_literal: true

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @comment = User.first.comments.build({ content: 'Comment for tests', post_id: Post.first.id })
  end

  test 'should be valid' do
    assert @comment.valid?
  end

  test 'user id should be present' do
    @comment.user_id = nil
    assert_not @comment.valid?
  end

  test 'content should be present' do
    @comment.content = nil
    assert_not @comment.valid?
  end

  test 'parent comment id might be present' do
    @comment.parent_id = Comment.first.id
    assert @comment.valid?
  end

  test 'content should be at most 1000 characters' do
    @comment.content = 'a' * 1001
    assert_not @comment.valid?
  end
end
