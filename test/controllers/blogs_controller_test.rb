# frozen_string_literal: true

require 'test_helper'

class BlogsControllerTest < ActionDispatch::IntegrationTest
  test "anyone can index published blogs" do
    published = Blog.published

    get blogs_url
    blogs = assigns(:blogs)

    assert_response :ok
    assert_equal published.count, blogs.count
  end

  test "admins can index ALL blogs" do
    sign_in_as users(:admin)
    get blogs_url

    blogs = assigns(:blogs)

    assert_response :ok
    assert_equal Blog.count, blogs.count
  end

  test "author can index ALL his blogs plus published" do
    author = users(:author)

    myblogs = Blog.published.or(author.blogs)

    sign_in_as author
    get blogs_url
    blogs = assigns(:blogs)

    assert_response :ok
    assert_equal myblogs.count, blogs.count
  end

  test "sally can not index unpublished blogs" do
    unpub_blog_id = blogs(:author2).id

    sign_in_as users(:sally)
    get blogs_url
    blogs = assigns(:blogs)

    assert_response :ok
    assert_not blogs.map(&:id).include?(unpub_blog_id), "an unpublished blog is present"
  end

  test "guests can view a published blog" do
    blog = blogs(:author1)
    get blog_url(blog)

    assert_response :success
    assert_equal blog.title, assigns(:blog).title
  end

  test "guests CANNOT view an unpublished blog" do
    get blog_url(blogs(:author2))

    assert_redirected_to root_url
  end

  test "authors can create and recieve a new blog" do
    sign_in_as users(:michelle)

    get new_blog_url
    assert_response :ok

    assert_difference('Blog.count') do
      post blogs_url, params: { blog: {
        title: "This is my blog",
        article: "I don't have much to say"
      } }
    end
    blog = assigns(:blog)

    assert_match(/this is my blog/i, blog.title)
    assert_match(/michelle/i, blog.author.display_name)
  end

  test "author can update blog" do
    sign_in_as users(:author)
    patch blog_url(blogs(:author1)), params: { blog: {
      title: "a new title"
    } }

    assert_match(/a new title/i, assigns(:blog).title)
  end

  test "admin can destroy a blog" do
    sign_in_as users(:admin)
    assert_difference('Blog.count', -1) do
      delete blog_url(blogs(:author1))
    end

    assert_redirected_to blogs_url
  end

  test "sally can destroy her blogs" do
    sign_in_as users(:sally)
    assert_difference('Blog.count', -1) do
      delete blog_url(blogs(:sally1))
    end

    assert_redirected_to blogs_url
  end
end
