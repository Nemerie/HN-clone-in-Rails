# frozen_string_literal: true

require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:example_user)
  end

  test 'login with valid email/invalid password' do
    post login_path, params: { session: { email: @user.email,
                                          password: 'wrong_password' } }
    assert_not is_logged_in?
  end

  test 'login with valid email and password' do
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' } }
    assert is_logged_in?
  end
end
