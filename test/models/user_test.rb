# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "higer roles can act as lower roles" do
    assert users(:admin).acts_as_admin?
    assert users(:admin).acts_as_author?

    assert users(:author).acts_as_author?
  end

  test "lower roles can NOT act as higher roles" do
    assert_not users(:author).acts_as_admin?
  end
end
