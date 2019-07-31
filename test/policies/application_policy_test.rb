# frozen_string_literal: true

require 'test_helper'

class ApplicationPolicyTest < PolicyAssertions::Test
  # Verify default policies are most restrictive

  test 'should not permit by default' do
    admin = users(:admin)
    assert_not ApplicationPolicy.new(admin, nil).show?
    assert_not ApplicationPolicy.new(admin, nil).index?
    assert_not ApplicationPolicy.new(admin, nil).create?
    assert_not ApplicationPolicy.new(admin, nil).new?
    assert_not ApplicationPolicy.new(admin, nil).update?
    assert_not ApplicationPolicy.new(admin, nil).edit?
    assert_not ApplicationPolicy.new(admin, nil).destroy?
  end
end
