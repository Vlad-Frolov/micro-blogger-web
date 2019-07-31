# frozen_string_literal: true

require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get login form" do
    get new_session_url

    assert_response :success
  end

  test "should get destroy" do
    delete session_url(1)

    assert_response :redirect
    assert_redirected_to root_url
  end
end
