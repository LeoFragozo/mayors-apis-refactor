require 'rails_helper'

RSpec.describe 'Api::V1::Cities', type: :request do
  let(:city) { create(:city) }

  describe 'GET /index' do
    it 'must return 200 http status' do
      get '/api/v1/cities'
      expect(response).to have_http_status(:ok)
    end
  end

  it 'must return the current city data' do
    create(:city)
    get '/api/v1/cities'
    expect(json_body[:data][0]).to have_key(:id)
    expect(json_body[:data][0]).to have_key(:name)
    expect(json_body[:data][0]).to have_key(:created_at)
    expect(json_body[:data][0]).to have_key(:updated_at)
    expect(json_body[:data][0][:name]).to eq(city.name)
  end

  it 'returns a 200 custom status code' do
    city = create(:city)
    get "/api/v1/cities/#{city.id}"
    expect(response).to have_http_status(200)
  end

  it 'must return city data' do
    city = create(:city)
    get "/api/v1/cities/#{city.id}"
    expect(json_body[:data][:name]).to eq(city.name)
  end
end

describe 'delete operations' do
  it 'allow delete of cities' do
    city = create(:city)
    delete "/api/v1/cities/#{city.id}"
    expect(response.status).to eq(200)
  end
end

describe 'update operation' do
  it 'successfully updates a city' do
    city = create(:city)
    body_data = { city: { name: city.name } }
    put "/api/v1/cities/#{city.id}", params: body_data
    expect(json_body[:message]).to eq('Cidade atualizada')
    expect(response.status).to eq(200)
  end
end
