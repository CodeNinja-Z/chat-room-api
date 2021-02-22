# https://medium.com/@sedwardscode/how-to-properly-test-a-rails-api-with-rspec-f15cbe1dfd11
require 'rails_helper'

RSpec.describe "Forums", type: :request do
  describe "index | get /api/v1/forums" do
    let!(:forums) { create_list(:random_forum, 20) }
    
    before { get '/api/v1/forums' }

    it 'returns all questions' do
      expect(JSON.parse(response.body).size).to eq(20)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  describe "create | post /api/v1/forums", type: :request do
    before(:each) do
      post '/api/v1/forums', params: { title: 'test title', description: 'test description' }
    end

    it 'returns the forum\'s title' do
      expect(JSON.parse(response.body)['title']).to eq('test title')
    end

    it 'returns the forum\'s description' do
      expect(JSON.parse(response.body)['description']).to eq('test description')
    end

    it 'returns a created status' do
      expect(response).to have_http_status(:created)
    end
  end

  describe "show | get /api/v1/forums/:id", type: :request do
    let(:forum) { create(:random_forum) }
    
    before { get "/api/v1/forums/#{forum.id}" }

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end

    it 'returns the forum\'s title' do
      expect(JSON.parse(response.body)['title']).to eq(forum.title)
    end

    it 'returns the forum\'s description' do
      expect(JSON.parse(response.body)['description']).to eq(forum.description)
    end
  end

  describe "update | put /api/v1/forums/:id", type: :request do
    let(:forum) { create(:random_forum) }

    it 'updates a forum' do
      @new_title = Faker::Lorem.sentence
      @new_description = Faker::Lorem.paragraph

      put "/api/v1/forums/#{forum.id}", params: {title: @new_title, description: @new_description}

      expect(response.status).to eq(202)
      expect(Forum.find(forum.id).title).to eq(@new_title)
      expect(Forum.find(forum.id).description).to eq(@new_description)
    end
  end

  describe "destroy | delete /api/v1/forums/:id" do
    let!(:forum_one) { create(:random_forum) }
    let!(:forum_two) { create(:random_forum) }
    
    it 'should delete the forum' do
      get "/api/v1/forums"
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq([JSON.parse(forum_one.to_json), JSON.parse(forum_two.to_json)])
      delete "/api/v1/forums/#{forum_one.id}"
      expect(response.status).to eq(204)
      get "/api/v1/forums"
      expect(JSON.parse(response.body)).to eq([JSON.parse(forum_two.to_json)])
    end
  end
end
