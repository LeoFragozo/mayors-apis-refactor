require 'rails_helper'

RSpec.describe 'Api::V1::Mayors', type: :request do
  let(:mayor) { create(:mayor) }

  describe 'GET /index' do
    it 'must return 200 http status' do
      get '/api/v1/mayors'
      expect(response).to have_http_status(:ok)
    end
  end

  it 'must return the current mayor data' do
    create(:mayor)
    get '/api/v1/mayors'
    expect(json_body[:data][0]).to have_key(:id)
    expect(json_body[:data][0]).to have_key(:name)
    expect(json_body[:data][0]).to have_key(:gender)
    expect(json_body[:data][0]).to have_key(:created_at)
    expect(json_body[:data][0]).to have_key(:updated_at)
    expect(json_body[:data][0][:name]).to eq(mayor.name)
    expect(json_body[:data][0][:gender]).to eq(mayor.gender)
  end

  it 'returns a 200 custom status code' do
    mayor = create(:mayor)
    get "/api/v1/mayors/#{mayor.id}"
    expect(response).to have_http_status(200)
  end

  it 'must return mayor data' do
    mayor = create(:mayor)
    get "/api/v1/mayors/#{mayor.id}"
    expect(json_body[:data][:name]).to eq(mayor.name)
    expect(json_body[:data][:gender]).to eq(mayor.gender)
  end
end

describe 'delete operations' do
  it 'allow delete of mayors' do
    mayor = create(:mayor)
    delete "/api/v1/mayors/#{mayor.id}"
    expect(response.status).to eq(200)
  end
end

describe 'update operation' do
  it 'successfully updates a mayor' do
    mayor = create(:mayor)
    body_data = { mayor: { name: mayor.name, gender: mayor.gender } }
    put "/api/v1/mayors/#{mayor.id}", params: body_data
    expect(json_body[:message]).to eq('Prefeito/a atualizado/a')
    expect(response.status).to eq(200)
  end
end

describe 'filter mayor by gender' do
  it 'show only male mayors' do
    mayor = create(:mayor)
    get '/api/v1/mayors/is_male'
    expect(json_body[:message]).to eq('Dados dos prefeitos carregados')
    expect(response.status).to eq(200)
  end

  it 'show only female mayors' do
    mayor = create(:mayor)
    get '/api/v1/mayors/is_female'
    expect(json_body[:message]).to eq('Dados das prefeitas carregadas')
    expect(response.status).to eq(200)
  end
end
