# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comment = post_comments(:one)
    @post = @comment.post
    @user = users(:one)
    sign_in @user

    @attrs = {
      content: Faker::TvShows::BigBangTheory.quote
    }
  end

  test 'should POST comments#create' do
    post post_comments_url(@post, locale: :ru), params: { post_comment: @attrs }

    comment = PostComment.find_by! content: @attrs[:content]

    assert_redirected_to post_url(@post)
    assert { comment }
  end

  test 'should DELETE comments#destroy' do
    delete post_comment_url(@post, @comment, locale: :ru)
    assert_redirected_to post_url(@post)
    assert { !PostComment.exists? @comment.id }
  end
end
