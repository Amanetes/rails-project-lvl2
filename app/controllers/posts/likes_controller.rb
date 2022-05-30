# frozen_string_literal: true

module Posts
  class LikesController < ApplicationController
    before_action :set_post, only: %i[create destroy]

    def create
      @like = @post.likes.build(user: current_user)
      redirect_to @post if @like.save
    end

    def destroy
      @like = @post.likes.find(params[:id])

      redirect_to @like.post if @like.destroy
    end

  end
end
