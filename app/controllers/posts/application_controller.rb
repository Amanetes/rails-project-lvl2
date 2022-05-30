# frozen_string_literal: true

module Posts
  class ApplicationController < ApplicationController
    before_action :authenticate_user!

    def set_post
      @post = Post.find(params[:post_id])
    end
  end
end
