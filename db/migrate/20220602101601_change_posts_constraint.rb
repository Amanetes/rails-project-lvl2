class ChangePostsConstraint < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:post_comments, :content, false)
  end
end
