# frozen_string_literal: true

require 'test_helper'

class UserPolicyTest < PolicyAssertions::Test
  test 'must authenticate for actions' do
    assert_raise Pundit::NotAuthorizedError do
      %w[create show update destroy].each do |action|
        UserPolicy.new(nil, User.new).send("#{action}?")
      end
    end
  end

  test 'should allow admin to scope' do
    scope = UserPolicy::Scope.new(users(:admin), User).resolve
    assert_equal User.count, scope.count
  end

  test 'non admins can only scope themselves' do
    %i[author].each do |user|
      scope = UserPolicy::Scope.new(users(user), User).resolve
      assert_equal 1, scope.count, "Scope did not have 1 result for #{user}"
      assert_equal users(user), scope.first, "Scope did not contain self for #{user}"
    end
  end

  test 'admins have role in permitted params' do
    policy = UserPolicy.new users(:admin), nil
    assert policy.permitted_attributes.include?(:role)
  end

  test 'non-admins can not edit roles' do
    %i[author].each do |user|
      policy = UserPolicy.new users(user), nil
      assert_not policy.permitted_attributes.include?(:role)
    end
  end

  # create
  test 'only admins can create' do
    assert_permit users(:admin), User, :create?

    %i[author].each do |user|
      assert_not_permitted users(user), User, :create?
    end
  end

  # delete
  test 'only admins can destroy' do
    assert_permit users(:admin), User, :destroy?

    %i[author].each do |user|
      assert_not_permitted users(user), User, :destroy?
    end
  end

  # show
  test 'admin can view any role' do
    %i[admin author].each do |user|
      assert_permit users(:admin), users(user), :show?
    end
  end

  test 'non-admins can view themselves' do
    %i[author].each do |user|
      assert_permit users(user), users(user), :show?
    end
  end

  test 'author roles can only view themselves' do
    %i[admin sally michelle].each do |user|
      assert_not_permitted users(:author), users(user), :show?
    end
  end

  # updates
  test 'admin can update any role' do
    %i[admin author].each do |user|
      assert_permit users(:admin), users(user), :update?
    end
  end

  test 'non-admins can update themselves' do
    %i[author].each do |user|
      assert_permit users(user), users(user), :update?
    end
  end

  test 'authors can not update other roles' do
    %i[admin sally michelle].each do |user|
      assert_not_permitted users(:author), users(user), :update?
    end
  end
end
