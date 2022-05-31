# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @user = users(:one)
    @category = categories(:one)
    sign_in @user

    @attrs = {
      title: Faker::Games::WarhammerFantasy.unique.hero,
      body: Faker::Games::WarhammerFantasy.quote,
      category_id: @category.id
    }
  end

  test 'should GET posts#index' do
    get root_path
    assert_response :success

    sign_out @user
    get root_path
    assert_response :success
  end

  test 'should GET posts#new' do
    get new_post_path
    assert_response :success
  end

  test 'should POST posts#create' do
    post posts_path, params: { post: @attrs }

    post = Post.find_by! title: @attrs[:title]

    assert_redirected_to post_path(post)
  end

  test 'should GET posts#show' do
    get post_path(@post)
    assert_response :success
  end

  test 'should GET posts#edit' do
    get edit_post_url(@post)
    assert_response :success
  end

  test 'should PATCH posts#update' do
    patch post_path(@post), params: { post: @attrs }
    assert_redirected_to post_path(@post)

    @post.reload

    assert { @post.title == @attrs[:title] }
  end

  test 'should DELETE posts#destroy' do
    delete post_path(@post)

    assert { !Post.exists?(@post.id) }

    assert_redirected_to root_path
  end
end
