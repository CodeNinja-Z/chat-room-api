class Api::V1::CommentsController < ApplicationController
  before_action :set_comment, only: [:update, :destroy]

  def create
    @comment = Comment.create!(comment_params)
    json_response(@comment.serializable_hash, :created)
  end

  def update
    @comment.update(comment_params)
    json_response(@comment.serializable_hash, :accepted)
  end

  def destroy
    @comment.destroy
    head :no_content
  end

  private

  def comment_params
    params.require(:comment).permit(:description, :forum_id, :parent_comment_id)
  end

  def set_comment
    @comment = Comment.find(params[:id]) # expect Front-end to pass a map with 'id' key
  end
end
