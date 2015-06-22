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

  describe 'create an app' do
    it 'is possible to create an app' do
      post '/apps', app_attributes, api_headers
      json = JSON.parse(response.body)

      expect(response.status).to eq 201
      expect(json['app'].keys).to include('id', 'name', 'user_id')
      expect(user.apps.length).to eq 1
    end
  end

  context 'with an app created' do
    before { post '/apps', app_attributes, api_headers }

    let(:app_id) { user.apps.first.id }

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
