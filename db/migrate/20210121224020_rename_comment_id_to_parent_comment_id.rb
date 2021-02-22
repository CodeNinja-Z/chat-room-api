class RenameCommentIdToParentCommentId < ActiveRecord::Migration[6.1]
  def change
    rename_column :comments, :comment_id, :parent_comment_id
    # rename_index :comments, 'comment_id', 'parent_comment_id' // Rails 4+ renames index for you
    change_column_null :comments, :parent_comment_id, true
  end
end
