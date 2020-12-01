require 'rails_helper'

RSpec.describe 'Appointments API', type: :request do
  let!(:user) { create(:user) }
  let!(:engineer) { create(:engineer) }
  let(:a) { { date: Date.today, duration: '1 hr', status: 'booked', user_id: user.id, engineer_id: engineer.id } }
  before { post '/api/v1/appointments', params: a }

  describe 'GET /appointments' do
    before { get '/api/v1/appointments' }
    it 'returns appointments' do
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /appointments/:id' do
    before { get '/api/v1/appointments' }

    context 'when the record exists' do
      it 'returns the engineer' do
        expect(json).not_to be_empty
        expect(json.count).to be >= 1
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      before { get '/api/v1/appointments/200' }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Appointment/)
      end
    end
  end

  describe 'POST /appointments' do
    let(:a) { { date: Date.today, duration: '4 hr', status: 'unbooked', user_id: user.id, engineer_id: engineer.id } }

    context 'when the request is valid' do
      before { post '/api/v1/appointments', params: a }

      it 'creates an engineer' do
        expect(json['duration']).to eq('4 hr')
        expect(json['status']).to eq('unbooked')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid) { { user_id: 1, engineer_id: 1, date: Date.today, status: 'booked' } }
      before { post '/api/v1/appointments', params: invalid }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/{"message":"Validation failed: User must exist, Engineer must exist, Duration can't be blank"}/)
      end
    end
  end
end
