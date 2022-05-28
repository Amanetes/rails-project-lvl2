# frozen_string_literal: true

class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_post, only: %i[show edit update destroy]
  before_action :verify_user, only: %i[edit update destroy]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show; end

  def new
    @post = current_user.posts.new
  end

  def edit; end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to @post, success: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, success: 'Post was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.destroy
      redirect_to root_path, success: 'Post was successfully destroyed.'
    else
      render :show, alert: 'Cannot be deleted'
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def verify_user
    redirect_to posts_path, alert: 'You cannot do smth with post' unless @post.creator.eql?(current_user)
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end
