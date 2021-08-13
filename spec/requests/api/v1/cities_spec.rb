require 'rails_helper'

RSpec.describe 'Api::V1::Cities', type: :request do
  context 'city crud operations' do
    let(:city) { create(:city) }

    it '.create' do
      get "/api/v1/cities/#{city.id}"
      expect(response).to have_http_status(200)
    end

    it '.show' do
      get "/api/v1/cities/#{city.id}"
      expect(json_body[:data][:name]).to eq(city.name)
    end

    it '.update' do
      body_data = { city: { name: city.name } }
      put "/api/v1/cities/#{city.id}", params: body_data
      expect(json_body[:message]).to eq('Cidade atualizada')
      expect(response.status).to eq(200)
    end

    it '.destroy' do
      delete "/api/v1/cities/#{city.id}"
      expect(response.status).to eq(200)
    end
  end

  context 'GET /index' do
    it 'must return 200 http status' do
      get '/api/v1/cities'
      expect(response).to have_http_status(:ok)
    end
  end

  context 'check city data' do
    let(:city) { create(:city) }
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
