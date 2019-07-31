# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "admin can list users" do
    sign_in_as users(:admin)
    get users_url

    assert_response :success
  end

  test "admin can create user" do
    sign_in_as users(:admin)

    get new_user_url
    assert :ok

    assert_difference('User.count') do
      post users_url, params: { user: {
        display_name: 'some user',
        email: 'new.user@mailinator.com',
        password: 'password',
        password_confirmation: 'password'
      } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "admin can view users" do
    sign_in_as users(:admin)
    get user_url(users(:admin))

    assert_response :success
  end

  test "admin can update user" do
    sign_in_as users(:admin)
    patch user_url(users(:admin)), params: { user: {
      display_name: 'I am admin'
    } }

    assert_redirected_to user_url(users(:admin))
  end

  test "admin can destroy user" do
    sign_in_as users(:admin)
    assert_difference('User.count', -1) do
      delete user_url(users(:admin))
    end

    assert_redirected_to users_url
  end

  test "author can view herself" do
    sign_in_as users(:admin)
    get user_url(users(:author))

    assert_response :success
  end

  test "author can update herself" do
    new_name = 'I am author!'

    sign_in_as users(:author)
    patch user_url(users(:author)), params: { user: {
      display_name: new_name
    } }

    assert_equal new_name, assigns(:user).display_name
  end

  test "sally CANNOT update phil" do
    sign_in_as users(:sally)
    patch user_url(users(:author)), params: { user: {
      display_name: 'I am author!'
    } }

    assert_redirected_to root_url
  end
end
