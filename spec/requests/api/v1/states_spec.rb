require 'rails_helper'

RSpec.describe 'Api::V1::States', type: :request do
  let(:state) { create(:state) }

  describe 'GET /states' do
    before { get '/api/v1/states' }
    it 'return states data' do
      expect(json_body).not_to be_empty
    end
    it 'return status 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /cities/:id ' do
    before { get "/api/v1/states/#{state.id}" }
    it 'show specific data' do
      expect(json_body[:data][:name]).to eq(state.name)
      expect(json_body[:data][:uf]).to eq(state.uf)
    end
    it 'create state data' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /api/v1/states' do
    let(:valid_state) do
      { name: state.name, uf: state.uf }
    end
    context 'when the city is valid' do
      before { post '/api/v1/states', params: valid_state }
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
    context 'when the city is invalid' do
      before { post '/api/v1/states', params: nil }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT states/:id' do
    context 'when state data exist' do
      it 'update state data' do
        body_data = { name: state.name, uf: state.uf }
        put "/api/v1/states/#{state.id}", params: body_data
        expect(response.status).to eq(204)
      end
    end

    context 'when state data doesnt exist' do
      it 'doesnt update state data' do
        body_data = { name: nil, uf: nil }
        put "/api/v1/states/#{state.id}", params: body_data
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE /states/:id' do
    it 'destroy state data' do
      delete "/api/v1/states/#{state.id}"
      expect(response.status).to eq(200)
    end
  end
end
