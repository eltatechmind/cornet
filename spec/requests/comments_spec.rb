require 'rails_helper'

RSpec.describe 'Comments API' do
   # initialize test data 
  let!(:user) { create(:user) }
  let!(:user_2) { create(:user)}
  let!(:project) { create(:project, user_id: user.id) }
  let!(:project_2) { create(:project, user_id: user_2.id) }
  let!(:task) { create(:task, project_id: project.id) }
  let!(:task_2) { create(:task, project_id: project_2.id) }
  let(:task_id) { task.id }
  let!(:comments) { create_list(:comment, 10, task_id: task.id) }
  let!(:comments_2) { create_list(:comment, 3, task_id: task_2.id) }
  let(:comment_id) { comments.first.id }
  let(:comment_id_2) { comments_2.first.id }
  let(:params) do
    {
        email: user.email,
        password: user.password
    }
  end
  before do
    post '/auth/sign_in', params: params
    @headers = {
        "access-token": response.headers["access-token"],
        "uid": response.headers["uid"],
        "client": response.headers["client"],
      }
  end

  # Test suite for GET /tasks/:task_id/comments
  describe 'GET /tasks/:task_id/comments' do
    before { get "/tasks/#{task_id}/comments", headers: @headers }

    context 'when task exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all task comments' do
        expect(json).not_to be_empty
        expect(JSON.parse(response.body)["data"].count).to eq(10)
      end
    end

    context 'when task does not exist' do
      let(:task_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Task/)
      end
    end
  end

  # Test suite for GET /tasks/:task_id/comments/:id
  describe 'GET /tasks/:task_id/comments/:id' do
    before { get "/tasks/#{task_id}/comments/#{comment_id}", headers: @headers }

    context 'when task comment exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the comment' do
        expect(JSON.parse(response.body)["data"]["id"].to_i).to eq(comment_id)
      end
    end

    context 'when task comment does not exist' do
      let(:comment_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Comment/)
      end
    end
  end

  # Test suite for PUT /tasks/:task_id/comments
  describe 'POST /tasks/:task_id/comments' do
    let(:valid_attributes) { { content: 'Visit Narnia', task_id: task_id } }

    context 'when request attributes are valid' do
      before { post "/tasks/#{task_id}/comments", params: valid_attributes, headers: @headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/tasks/#{task_id}/comments", params: {task_id: task_id}, headers: @headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Content can't be blank/)
      end
    end
  end

  # Test suite for PUT /tasks/:task_id/comments/:id
  describe 'PUT /tasks/:task_id/comments/:id' do
    let(:valid_attributes) { { content: 'Mozart' } }

    before { put "/tasks/#{task_id}/comments/#{comment_id}", params: valid_attributes, headers: @headers }

    context 'when comment exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the comment' do
        updated_comment = Comment.find(comment_id)
        expect(updated_comment.content).to match(/Mozart/)
      end
    end

    context 'when the comment does not exist' do
      let(:comment_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Comment/)
      end
    end
  end

  # Test suite for DELETE /comments/:id
  describe 'DELETE /tasks/task_id/comments/:comment_id' do
    before { delete "/tasks/#{task_id}/comments/#{comment_id}", headers: @headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end