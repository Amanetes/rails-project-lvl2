# frozen_string_literal: true

module Posts
  class CommentsController < ApplicationController
    before_action :set_post, only: :create
    before_action :set_comment, only: :destroy

    def create
      @comment = @post.comments.build(comment_params)
      @comment.user = current_user

      if @comment.save
        redirect_to @post, success: t('flash.comments.new.success')
      else
        render 'posts/show', status: :unprocessable_entity
      end
    end

    def destroy
      if @comment.destroy
        redirect_to post_path(@comment.post), success: t('flash.comments.destroy.success')
      else
        render 'posts/show', alert: t('flash.comments.destroy.error')
      end
    end

    private

    def set_comment
      @comment = PostComment.find(params[:id])
    end

    def comment_params
      params.require(:post_comment).permit(:content, :parent_id)
    end
  end
end
