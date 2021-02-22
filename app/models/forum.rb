class Forum < ApplicationRecord
  include ActiveModel::Serializers::JSON # https://api.rubyonrails.org/classes/ActiveModel/Serialization.html

  has_many :comments

  validates :title, presence: true
  validates :description, presence: true

  def formatted_comments
    comments.select(:id, :description, :parent_comment_id, :forum_id).order(:created_at)
  end

  def attributes
    {
      'id' => id,
      'title' => title,
      'description' => description
    }
  end
end
