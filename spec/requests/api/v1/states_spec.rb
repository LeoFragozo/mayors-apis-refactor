require 'rails_helper'

RSpec.describe 'Api::V1::States', type: :request do
  let(:state) { create(:state) }

  describe 'GET /index' do
    it 'must return 200 http status' do
      get '/api/v1/states'
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /states ' do
    it 'create state data' do
      get "/api/v1/states/#{state.id}"
      expect(response).to have_http_status(200)
    end
    it 'show states data' do
      get "/api/v1/states/#{state.id}"
      expect(json_body[:data][:name]).to eq(state.name)
      expect(json_body[:data][:uf]).to eq(state.uf)
    end
  end

  describe 'PUT states/:id' do
    context 'when state data exist' do
      it 'update state data' do
        body_data = { state: { name: state.name, uf: state.uf } }
        put "/api/v1/states/#{state.id}", params: body_data
        expect(response.status).to eq(204)
      end
    end

    context 'when state data doesnt exist' do
      it 'doesnt update state data' do
        body_data = { state: { name: nil, uf: nil } }
        put "/api/v1/states/#{state.id}", params: body_data
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'PUT /states/:id' do
    it 'destroy state data' do
      delete "/api/v1/states/#{state.id}"
      expect(response.status).to eq(200)
    end
  end

  describe 'create state data' do
    it 'gets state data' do
      create(:state)
      get '/api/v1/states'
      expect(json_body[:data][0]).to have_key(:id)
      expect(json_body[:data][0]).to have_key(:name)
      expect(json_body[:data][0]).to have_key(:uf)
      expect(json_body[:data][0]).to have_key(:created_at)
      expect(json_body[:data][0]).to have_key(:updated_at)
      expect(json_body[:data][0][:name]).to eq(state.name)
      expect(json_body[:data][0][:uf]).to eq(state.uf)
    end
  end
end
