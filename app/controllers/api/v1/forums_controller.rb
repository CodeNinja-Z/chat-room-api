class Api::V1::ForumsController < ApplicationController
  before_action :set_forum, only: [:show, :update, :destroy]

  def index
    @forums = Forum.all.order(:created_at)
    json_response(@forums)
  end

  def create
    @forum = Forum.create!(forum_params)
    json_response(@forum.serializable_hash, :created)
  end

  def show
    # @comments = @forum.all_comments
    # json_response({forum: @forum, comments: @comments})
    @serialized_forum = @forum.serializable_hash(methods: :formatted_comments)
    # @serialized_forum = @forum.serializable_hash(include: { comments: { only: ['id', 'description', 'forum_id', 'parent_comment_id'] }})
    json_response(@serialized_forum)
  end
  
  def update
    @forum.update(forum_params)
    json_response(@forum.serializable_hash, :accepted)
  end

  def destroy
    @forum.destroy
    head :no_content
  end

  private

  def forum_params
    params.require(:forum).permit(:title, :description)
  end

  def set_forum
    @forum = Forum.find(params[:id]) # expect Front-end to pass a map with 'id' key
  end
end
