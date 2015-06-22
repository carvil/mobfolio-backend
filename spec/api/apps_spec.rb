require 'rails_helper'

RSpec.describe 'Managing apps', type: :request do
  let(:app_attributes) do
    {
      app: {
        name: 'Idea Canvas App'
      }
    }
  end
  let(:api_headers) do
    { 'HTTP_AUTHORIZATION' => "Token token=#{user.authentication_token}" }
  end
  let!(:user) { create(:user) }

  context 'validations' do
    it 'is not possible to perform an action without a token' do
      post '/apps', { app: { name: 'App name' } }, {}

      expect(response.status).to eq 401
      expect(response.body).to include('Access denied')
    end

    it 'is not possible to create an app without params' do
      post '/apps', {}, api_headers

      expect(response.status).to eq 400
      expect(response.body).to include("param is missing or the value is empty: app")
    end

    it 'is not possible to create an app without a name' do
      post '/apps', { app: { fake: 'fake' } }, api_headers

      expect(response.status).to eq 400
      expect(response.body).to include("can't be blank")
    end

    it 'is not possible to view a nonexistent app' do
      get '/apps/fake', {}, api_headers
      expect(response.status).to eq 404
      expect(response.body).to include('Record not found')
    end

    it 'is not possible to edit a nonexistent app' do
      patch '/apps/fake', { app: { name: 'new name' }}, api_headers
      expect(response.status).to eq 404
      expect(response.body).to include('Record not found')
    end

    it 'is not possible to delete a nonexistent app' do
      delete '/apps/fake', {}, api_headers
      expect(response.status).to eq 404
      expect(response.body).to include('Record not found')
    end
  end

  context 'with an app created' do
    before { post '/apps', app_attributes, api_headers }

    let(:app_id) { user.apps.first.id }

    it 'returns the app info and success status' do
      json = JSON.parse(response.body)

      expect(response.status).to eq 201
      expect(json['app'].keys).to include('id', 'name', 'user_id')
      expect(user.apps.length).to eq 1
    end

    it 'is possible to view an app' do
      get "/apps/#{app_id}", {}, api_headers
      json = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(json['app']['id']).to eq app_id
    end

    it 'is possible to view all the apps' do
      get "/apps", {}, api_headers
      json = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(json['apps']).to be_a_kind_of(Array)
      expect(json['apps'].length).to eq 1
    end

    it 'is possible to update an app' do
      patch "/apps/#{app_id}", { name: 'New name' }, api_headers
      json = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(json['app']['name']).to eq 'New name'
    end

    it 'is possible to delete an app' do
      delete "/apps/#{app_id}", {}, api_headers
      expect(response.status).to eq 204
      expect(response.body).to eq ''
    end
  end
end
