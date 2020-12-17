require 'rails_helper'

RSpec.describe 'Engineers API', type: :request do
  let!(:engineers) { create_list(:engineer, 10) }
  let(:engineer_id) { engineers.first.id }

  describe 'GET /engineers' do
    before { get '/api/v1/engineers' }

    it 'returns engineers' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /engineers/:id' do
    before { get "/api/v1/engineers/#{engineer_id}" }

    context 'when the record exists' do
      it 'returns the engineer' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(engineer_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:engineer_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Engineer/)
      end
    end
  end

  describe 'POST /engineers' do
    let(:valid_attributes) { { name: 'John', stack: 'MERN', location: 'Texas', avatar_link: 'link' } }

    context 'when the request is valid' do
      before { post '/api/v1/engineers', params: valid_attributes }

      it 'creates an engineer' do
        expect(json['name']).to eq('John')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/engineers', params: { name: 'Foobar', stack: 'Full', location: 'Bosnia' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/{"message":"Validation failed: Avatar link can't be blank"}/)
      end
    end
  end

  describe 'PUT /engineers/:id' do
    let(:valid_attributes) { { name: 'Angelist' } }

    context 'when the record exists' do
      before { put "/api/v1/engineers/#{engineer_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /engineers/:id' do
    before { delete "/api/v1/engineers/#{engineer_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
