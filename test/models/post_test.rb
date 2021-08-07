# frozen_string_literal: true

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Example User', email: 'user@example.com', id: 101,
                     password: 'foobar', password_confirmation: 'foobar')
    @post = @user.posts.build({ title: 'Example title', url: 'http://example.com/' })
  end

  test 'should be valid' do
    assert @post.valid?
  end

  test 'user id should be present' do
    @post.user_id = nil
    assert_not @post.valid?
  end

  test 'title should be present' do
    @post.title = ''
    assert_not @post.valid?
  end

  test 'url should be present' do
    @post.url = ''
    assert_not @post.valid?
  end

  test 'title should be at most 100 characters' do
    @post.title = 'a' * 101
    assert_not @post.valid?
  end
end
