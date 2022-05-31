# frozen_string_literal: true

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @user = users(:one)
    @like = post_likes(:one)
    sign_in @user
  end

  test 'should POST likes#create' do
    post post_likes_path(@post)

    like = PostLike.find_by! user_id: @user.id

    assert { like }
  end

  test 'should DELETE likes#destroy' do
    delete post_like_path(@post, @like)
    assert { !PostLike.exists? @like.id }
    assert_response :redirect
  end
end
