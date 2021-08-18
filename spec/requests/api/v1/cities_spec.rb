require 'rails_helper'

RSpec.describe 'Api::V1::Cities', type: :request do
  let(:city) { create(:city) }

  describe 'GET /cities' do
    before { get '/api/v1/cities' }
    it 'return cities data' do
      expect(json_body).not_to be_empty
    end
    it 'return status 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /cities/:id ' do
    before { get "/api/v1/cities/#{city.id}" }
    it 'show spefic city data' do
      expect(json_body[:data][:name]).to eq(city.name)
    end
    it 'return status 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /api/v1/cities' do
    let!(:name) { create(:city) }
    let!(:state) { create(:state) }
    let(:valid_city) do
      { city: {name: 'Carazinho'}, state_id: state.id }
    end
    context 'when the city is valid' do
      before { post '/api/v1/cities', params: valid_city }
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
      context 'when the city is invalid' do
        before { post '/api/v1/cities', params: nil }
        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end
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
end
