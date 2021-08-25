require 'rails_helper'

RSpec.describe 'Api::V1::Mayors', type: :request do
  let(:mayor) { create(:mayor) }

  describe 'GET /mayors' do
    before { get '/api/v1/mayors' }
    it 'return mayors data' do
      expect(json_body).not_to be_empty
    end
    it 'return status 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /mayors/:id ' do
    before { get "/api/v1/mayors/#{mayor.id}" }
    it 'show spefic mayor data' do
      expect(json_body[:data][:name]).to eq(mayor.name)
      expect(json_body[:data][:gender]).to eq(mayor.gender)
    end
    it 'return 200 ' do
      get "/api/v1/mayors/#{mayor.id}"
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /api/v1/cities' do
    let!(:name) { create(:city) }
    let!(:city) { create(:city) }
    let(:valid_mayor) do
      { name: mayor.name, gender: mayor.gender, city_id: city.id }
    end
    context 'when the mayor is valid' do
      before { post '/api/v1/mayors', params: valid_mayor }
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
    context 'when the city is invalid' do
      before { post '/api/v1/mayors', params: nil }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT mayors/:id' do
    context 'when mayor data exist' do
      it 'update mayor data' do
        body_data = { name: mayor.name, gender: mayor.gender }
        put "/api/v1/mayors/#{mayor.id}", params: body_data
        expect(response.status).to eq(204)
      end
    end

    context 'when mayor data doesnt exist' do
      it 'doesnt update mayor data' do
        body_data = { name: nil, gender: nil }
        put "/api/v1/mayors/#{mayor.id}", params: body_data
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE mayors:/id'
  it '.destroy mayor data' do
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
