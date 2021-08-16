# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @comment = comments(:example_comment)
    @post = posts(:example_post)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Comment.count' do
      post comments_new_path, params: { content: "random content",
                                        post: @post,
                                        parent: @comment }
    end
    assert_redirected_to login_url
  end
end
