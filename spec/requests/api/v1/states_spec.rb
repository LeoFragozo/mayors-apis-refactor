require 'rails_helper'

RSpec.describe 'Api::V1::States', type: :request do
  context 'state crud operations' do
    let(:state) { create(:state) }

    it '.create' do
      get "/api/v1/states/#{state.id}"
      expect(response).to have_http_status(200)
    end

    it '.show' do
      get "/api/v1/states/#{state.id}"
      expect(json_body[:data][:name]).to eq(state.name)
      expect(json_body[:data][:uf]).to eq(state.uf)
    end

    it '.destroy' do
      delete "/api/v1/states/#{state.id}"
      expect(response.status).to eq(200)
    end

    it ',update' do
      body_data = { state: { name: state.name, uf: state.uf } }
      put "/api/v1/states/#{state.id}", params: body_data
      expect(json_body[:message]).to eq('Estado atualizado')
      expect(response.status).to eq(200)
    end
  end

  context 'GET /index' do
    it 'must return 200 http status' do
      get '/api/v1/states'
      expect(response).to have_http_status(:ok)
    end
  end

  context 'check state data' do
    let(:state) { create(:state) }
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
