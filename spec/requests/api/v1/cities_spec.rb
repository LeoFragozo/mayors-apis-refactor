require 'rails_helper'

RSpec.describe 'Api::V1::Cities', type: :request do
  let(:city) { create(:city) }

  describe 'GET /index' do
    it 'must return 200 http status' do
      get '/api/v1/cities'
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /cities ' do
    it '.create' do
      get "/api/v1/cities/#{city.id}"
      expect(response).to have_http_status(200)
    end
    it '.show' do
      get "/api/v1/cities/#{city.id}"
      expect(json_body[:data][:name]).to eq(city.name)
    end
  end

  describe 'PUT /cities/:id' do
    it '.update' do
      body_data = { city: { name: city.name } }
      put "/api/v1/cities/#{city.id}", params: body_data
      expect(json_body[:message]).to eq('Cidade atualizada')
      expect(response.status).to eq(200)
    end
  end

  describe 'DELETE cities/:id' do
    it '.destroy' do
      delete "/api/v1/cities/#{city.id}"
      expect(response.status).to eq(200)
    end
  end

  describe 'create city data' do
    it 'gets city data' do
      create(:city)
      get '/api/v1/cities'
      expect(json_body[:data][0]).to have_key(:id)
      expect(json_body[:data][0]).to have_key(:name)
      expect(json_body[:data][0]).to have_key(:created_at)
      expect(json_body[:data][0]).to have_key(:updated_at)
      expect(json_body[:data][0][:name]).to eq(city.name)
    end
  end
end
