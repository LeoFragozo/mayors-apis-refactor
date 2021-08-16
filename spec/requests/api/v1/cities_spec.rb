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
    it 'create cities data' do
      get "/api/v1/cities/#{city.id}"
      expect(response).to have_http_status(200)
    end
    it 'show city data' do
      get "/api/v1/cities/#{city.id}"
      expect(json_body[:data][:name]).to eq(city.name)
    end
  end

  describe 'PUT /cities/:id' do
    context 'when city data exist' do
      it 'update city data' do
        body_data = { city: { name: city.name } }
        put "/api/v1/cities/#{city.id}", params: body_data
        expect(response.status).to eq(204)
      end
    end

    context 'when city dosent exist' do
      it 'doesnt update city data' do
        body_data = { city: { name: nil } }
        put "/api/v1/cities/#{city.id}", params: body_data
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE cities/:id' do
    it 'destroy city data' do
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
