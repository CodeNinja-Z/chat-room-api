class AddParentCommentToComments < ActiveRecord::Migration[6.1]
  # def change
  #   add_reference :comments, :parent_comment, index: true
  #   add_foreign_key :comments, :parent_comment
  #   # add_reference :comments, :parent_comment, index: true, foreign_key: true
  #   change_column :comments, :parent_comment_id, null: true
  # end
end
