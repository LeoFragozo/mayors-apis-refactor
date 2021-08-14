require 'rails_helper'

RSpec.describe 'Api::V1::Mayors', type: :request do
  let(:mayor) { create(:mayor) }

  describe 'GET /index' do
    it 'must return 200 http status' do
      get '/api/v1/mayors'
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /mayors ' do
    it '.create' do
      get "/api/v1/mayors/#{mayor.id}"
      expect(response).to have_http_status(200)
    end
    it '.show' do
      get "/api/v1/mayors/#{mayor.id}"
      expect(json_body[:data][:name]).to eq(mayor.name)
      expect(json_body[:data][:gender]).to eq(mayor.gender)
    end
  end

  describe 'PUT mayors/:id' do
    it '.update' do
      body_data = { mayor: { name: mayor.name, gender: mayor.gender } }
      put "/api/v1/mayors/#{mayor.id}", params: body_data
      expect(json_body[:message]).to eq('Prefeito/a atualizado/a')
      expect(response.status).to eq(200)
    end
  end

  describe 'DELETE mayors:/id'
  it '.destroy' do
    delete "/api/v1/mayors/#{mayor.id}"
    expect(response.status).to eq(200)
  end
end

context 'mayor gender data' do
  let(:mayor) { create(:mayor) }
  it 'the mayor is male' do
    create(:mayor, name: mayor.name, gender: 'Male')
    get '/api/v1/mayors?gender=Male'
    expect(json_body[:data][0]).to have_key(:id)
    expect(json_body[:data][0]).to have_key(:name)
    expect(json_body[:data][0]).to have_key(:gender)
    expect(json_body[:data][0]).to have_key(:created_at)
    expect(json_body[:data][0]).to have_key(:updated_at)
    expect(json_body[:data][0][:name]).to eq(mayor.name)
    expect(json_body[:data][0][:gender]).to eq('Male')
  end

  it 'the mayor is female' do
    create(:mayor, name: mayor.name, gender: 'Female')
    get '/api/v1/mayors?gender=Female'
    expect(json_body[:data][0]).to have_key(:id)
    expect(json_body[:data][0]).to have_key(:name)
    expect(json_body[:data][0]).to have_key(:gender)
    expect(json_body[:data][0]).to have_key(:created_at)
    expect(json_body[:data][0]).to have_key(:updated_at)
    expect(json_body[:data][0][:name]).to eq(mayor.name)
    expect(json_body[:data][0][:gender]).to eq('Female')
  end
end
