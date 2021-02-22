class Comment < ApplicationRecord
  include ActiveModel::Serializers::JSON

  belongs_to :forum
  belongs_to :parent_comment, class_name: "Comment", required: false
  has_many :child_comments, class_name: "Comment", foreign_key: :parent_comment_id

  validates :description, presence: true
  validates :forum, presence: true

  # with_options presence: true, allow_blank: false do
  #   validates :forum
  #   validates :description
  # end

  def attributes
    {
      'id' => id,
      'description' => description,
      'forum_id' => forum_id,
      'parent_comment_id' => parent_comment_id
    }
  end  
end
