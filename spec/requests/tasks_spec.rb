require 'rails_helper'

RSpec.describe 'Tasks API', type: :request do
  # initialize test data 
  let!(:user) { create(:user) }
  let!(:user_2) { create(:user)}
  let!(:project) { create(:project, user_id: user.id) }
  let!(:project_2) { create(:project, user_id: user_2.id) }
  let!(:tasks) { create_list(:task, 10, project_id: project.id) }
  let!(:tasks_2) { create_list(:task, 3, project_id: project_2.id) }
  let!(:task_id) { tasks.first.id }
  let!(:task_id_2) { tasks_2.first.id }
  let!(:params) do
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

  # Test suite for GET /tasks
  describe 'GET /tasks' do
    # make HTTP get request before each example
    before { get '/tasks', headers: @headers }

    it 'returns tasks' do
      expect(json).not_to be_empty
      expect(JSON.parse(response.body)["data"].count).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /tasks/:id
  describe 'GET /tasks/:id' do

    context 'when the record exists' do
      before { get "/tasks/#{task_id}", headers: @headers }
      it 'returns the task' do
        expect(json).not_to be_empty
        expect(JSON.parse(response.body)["data"]["id"].to_i).to eq(task_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      before { get "/tasks/#{task_id}", headers: @headers }
      let(:task_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Task/)
      end
    end
  end

  # Test suite for POST /tasks
  describe 'POST /tasks' do
    # valid payload
    let(:valid_attributes) { { name: 'Learn Elm', project_id: project.id} }

    context 'when the request is valid' do
      before { post '/tasks', params: valid_attributes, headers: @headers }

      it 'creates a task' do
        expect(JSON.parse(response.body)["data"]["attributes"]["name"]).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/tasks', params: { project_id: project.id}, headers: @headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match("{\"message\":\"Validation failed: Name can't be blank, Name is too short (minimum is 6 characters)\"}")
      end
    end
  end

  # Test suite for PUT /tasks/:id
  describe 'PUT /tasks/:id' do
    let(:valid_attributes) { { name: 'Shopping' } }

    context 'when the record exists' do
      before { put "/tasks/#{task_id}", params: valid_attributes, headers: @headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when you are not authorized' do
      before { put "/tasks/#{task_id_2}", params: valid_attributes, headers: @headers }

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  # Test suite for DELETE /tasks/:id
  describe 'DELETE /tasks/:id' do
    context 'when the record exists' do
      before { delete "/tasks/#{task_id}", headers: @headers }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when you are not authorized' do
      before { delete "/tasks/#{task_id_2}" }

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end
end