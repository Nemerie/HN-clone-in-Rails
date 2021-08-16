# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @post = posts(:example_post)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Post.count' do
      post submit_path, params: { post: { title: "test title",
                                          url: "https://testurl.com" } }
    end
    assert_redirected_to login_url
  end
end
