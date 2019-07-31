# frozen_string_literal: true

class BlogsController < ApplicationController
  before_action :set_blog, only: %i[show edit update destroy]

  def index
    @blogs = policy_scope Blog.all
  end

  def show; end

  def new
    @blog = Blog.new
    authorize @blog
  end

  def edit; end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id

    authorize @blog

    if @blog.save
      redirect_to @blog, notice: 'Blog was successfully created.'
    else
      render :new
    end
  end

  def update
    if @blog.update(blog_params)
      redirect_to @blog, notice: 'Blog was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_url, notice: 'Blog was successfully destroyed.'
  end

  private

    def set_blog
      @blog = Blog.find(params[:id])
      authorize @blog
    end

    def blog_params
      params.require(:blog).permit(policy(Blog).permitted_attributes)
    end
end
