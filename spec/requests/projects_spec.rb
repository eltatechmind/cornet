# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('Projects API', type: :request) do
  # initialize test data
  let!(:user) { create(:user) }
  let!(:user_2) { create(:user) }
  let!(:projects) { create_list(:project, 10, user_id: user.id) }
  let!(:projects_2) { create_list(:project, 3, user_id: user_2.id) }
  let(:project_id) { projects.first.id }
  let(:project_id_2) { projects_2.first.id }
  let(:params) do
    {
      email: user.email,
      password: user.password,
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

  # Test suite for GET /projects
  describe 'GET /projects' do
    # make HTTP get request before each example
    before { get '/projects', headers: @headers }

    it 'returns projects' do
      expect(json).not_to(be_empty)
      expect(JSON.parse(response.body)["data"].count).to(eq(10))
    end

    it 'returns status code 200' do
      expect(response).to(have_http_status(200))
    end
  end

  # Test suite for GET /projects/:id
  describe 'GET /projects/:id' do
    context 'when the record exists' do
      before { get "/projects/#{project_id}", headers: @headers }
      it 'returns the project' do
        expect(json).not_to(be_empty)
        expect(JSON.parse(response.body)["data"]["id"].to_i).to(eq(project_id))
      end

      it 'returns status code 200' do
        expect(response).to(have_http_status(200))
      end
    end

    context 'when the record does not exist' do
      before { get "/projects/#{project_id}", headers: @headers }
      let(:project_id) { 100 }

      it 'returns status code 404' do
        expect(response).to(have_http_status(404))
      end

      it 'returns a not found message' do
        expect(response.body).to(match(/Couldn't find Project/))
      end
    end
  end

  # Test suite for POST /projects
  describe 'POST /projects' do
    # valid payload
    let(:valid_attributes) { { name: 'Learn Elm', user_id: user.id } }

    context 'when the request is valid' do
      before { post '/projects', params: valid_attributes, headers: @headers }

      it 'creates a project' do
        expect(JSON.parse(response.body)["data"]["attributes"]["name"]).to(eq('Learn Elm'))
      end

      it 'returns status code 201' do
        expect(response).to(have_http_status(201))
      end
    end

    context 'when the request is invalid' do
      before { post '/projects', params: { user_id: user.id }, headers: @headers }

      it 'returns status code 422' do
        expect(response).to(have_http_status(422))
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to(match(/Validation failed: Name can't be blank/))
      end
    end
  end

  # Test suite for PUT /projects/:id
  describe 'PUT /projects/:id' do
    let(:valid_attributes) { { name: 'Shopping' } }

    context 'when the record exists' do
      before { put "/projects/#{project_id}", params: valid_attributes, headers: @headers }

      it 'updates the record' do
        expect(response.body).to(be_empty)
      end

      it 'returns status code 200' do
        expect(response).to(have_http_status(200))
      end
    end

    context 'when you are not authorized' do
      before { put "/projects/#{project_id_2}", params: valid_attributes, headers: @headers }

      it 'returns status code 401' do
        expect(response).to(have_http_status(401))
      end
    end
  end

  # Test suite for DELETE /projects/:id
  describe 'DELETE /projects/:id' do
    context 'when the record exists' do
      before { delete "/projects/#{project_id}", headers: @headers }

      it 'returns status code 200' do
        expect(response).to(have_http_status(200))
      end
    end

    context 'when you are not authorized' do
      before { delete "/projects/#{project_id_2}" }

      it 'returns status code 401' do
        expect(response).to(have_http_status(401))
      end
    end
  end
end
