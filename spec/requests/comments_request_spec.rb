require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let!(:forum) { create(:random_forum) }
  let!(:parent_comment) { create(:random_comment) }
  let(:comment) { create(:random_comment) }

  describe "create | post /api/v1/forums/:id/comments", type: :request do
    before(:each) do
      post "/api/v1/forums/#{forum.id}/comments", params: { description: 'test description', forum_id: forum.id }
    end

    it 'returns the forum\'s id' do
      expect(JSON.parse(response.body)['forum_id']).to eq(forum.id)
    end

    it 'returns the comment\'s description' do
      expect(JSON.parse(response.body)['description']).to eq('test description')
    end

    it 'returns a created status' do
      expect(response).to have_http_status(:created)
    end
  end

  describe "update | put /api/v1/forums/:id/comments/:id", type: :request do
    before(:each) do
      parent_comment.forum = forum
      comment.forum = forum
      comment.parent_comment = parent_comment
      # comment = create(:random_comment, :with_parent_comment)
    end

    it 'updates a comment' do
      @new_description = Faker::Lorem.paragraph

      put "/api/v1/forums/#{forum.id}/comments/#{comment.id}", params: {description: @new_description}

      expect(response.status).to eq(202) # => :accepted
      expect(Comment.find(comment.id).forum_id).to eq(forum.id)
      expect(Comment.find(comment.id).description).to eq(@new_description)
      expect(Comment.find(comment.id).parent_comment_id).to eq(parent_comment.parent_comment_id)
    end
  end

  describe "destroy | delete /api/v1/forums/:id/comments/:id" do
    before(:each) do
      comment.forum = forum
    end
    
    it 'should delete the comment' do
      delete "/api/v1/forums/#{forum.id}/comments/#{comment.id}"
      expect(response.status).to eq(204) # => :no_content
    end
  end

  # Use subject to call API endpoint:
  # subject { get :new }

  # it 'GET articles#new creates new instance of Article' do
  #   subject
  #   expect(assigns[:article]).to be_a(Article)
  # end
end
