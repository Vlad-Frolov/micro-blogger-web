# frozen_string_literal: true

require 'test_helper'

class BlogPolicyTest < PolicyAssertions::Test
  test 'anyone can view a published blog' do
    assert_permit nil, blogs(:author1), :show?
  end

  test 'must authenticate for modification' do
    assert_raise Pundit::NotAuthorizedError do
      %w[create update destroy].each do |action|
        UserPolicy.new(nil, User.new).send("#{action}?")
      end
    end
  end

  # show
  test 'author can show his unpublished blog' do
    assert_permit users(:author), blogs(:author2), :show?
  end

  test 'admin can show anothers unpublishd blog' do
    assert_permit users(:admin), blogs(:author2), :show?
  end

  test 'sally CANNOT show authors unpublishd blog' do
    assert_not_permitted users(:sally), blogs(:author2), :show?
  end

  # update
  test 'author can update his unpublished blog' do
    assert_permit users(:author), blogs(:author2), :update?
  end

  test 'admin can update anothers unpublishd blog' do
    assert_permit users(:admin), blogs(:author2), :update?
  end

  test 'sally CANNOT update authors unpublishd blog' do
    assert_not_permitted users(:sally), blogs(:author2), :update?
  end

  # create
  test 'users can create a new blog' do
    assert_permit users(:admin), Blog.new, :create?
    assert_permit users(:author), Blog.new, :create?
    assert_permit users(:sally), Blog.new, :create?
    assert_permit users(:michelle), Blog.new, :create?
  end

  # destroy
  test 'authors can destroy their own blogs' do
    assert_permit users(:author), blogs(:author1), :destroy?
  end

  test 'admins can destroy any blogs' do
    assert_permit users(:admin), blogs(:author1), :destroy?
  end

  test 'users CANOT destroy another authors blogs' do
    assert_not_permitted users(:sally), blogs(:author1), :destroy?
  end
end
