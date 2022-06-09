# frozen_string_literal: true

class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @comment = @post.comments.build
    @like = @post.likes.find_by(user: current_user)
  end

  def new
    @post = current_user.posts.new
  end

  def edit; end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:success] = t('flash.posts.new.success')
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      flash[:success] = t('flash.posts.update.success')
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = t('flash.posts.delete.success')
      redirect_to root_path
    else
      flash.now[:alert] = t('flash.posts.delete.error')
      render :show
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end
