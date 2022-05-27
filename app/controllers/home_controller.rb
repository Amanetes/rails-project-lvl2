# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @posts = Post.all.order(created_at: :desc)
  end
end
