require 'rails_helper'

RSpec.describe 'Appointments API', type: :request do
  let!(:user) { create(:user) }
  let!(:engineer) { create(:engineer) }
  let(:a) { { date: Date.today, duration: '1 hr', status: 'booked', user_id: user, engineer_id: engineer } }
  before { post '/api/v1/appointments', params: a }

  describe 'GET /appointments' do
    before { get '/api/v1/appointments' }
    it 'returns appointments' do
      expect(json).not_to be_empty
    end
  end
end
