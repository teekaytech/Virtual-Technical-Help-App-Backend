require 'rails_helper'

RSpec.describe 'Appointments API', type: :request do
  let!(:user) { create(:user) }
  let!(:engineer) { create(:engineer) }
  let(:appointment) { create(:appointment, user: user, engineer: engineer) }
  let(:a) { { date: Date.today, duration: '1 hr', status: 'booked', user_id: user.id, appointment_id: appointment.id } }
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
      it 'returns the appointment' do
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

      it 'creates an appointment' do
        expect(json['duration']).to eq('4 hr')
        expect(json['status']).to eq('unbooked')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid) { { user_id: 1, appointment_id: 1, date: Date.today, status: 'booked' } }
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

  describe 'PUT /appointments/:id' do
    let(:valid_attributes) { { duration: '10 hrs' } }

    context 'when the record exists' do
      before { put "/api/v1/appointments/#{appointment.id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /appointments/:id' do
    before { delete "/api/v1/appointments/#{appointment.id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
