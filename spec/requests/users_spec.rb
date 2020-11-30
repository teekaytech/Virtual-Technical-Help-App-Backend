require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  # rubocop:disable Style/BlockDelimiters
  let(:valid_attributes) {
    { name: 'taofeek', username: 'teekaytech', email: 'teekaytech@gmail.com',
      password: 'password', password_confirmation: 'password' }
  }
  # rubocop:enable Style/BlockDelimiters
  before { post '/api/v1/users', params: valid_attributes }

  # Test suite for POST /users
  describe 'POST /users' do
    context 'when the request is valid' do
      it 'creates a user' do
        expect(json['user']['name']).to eq('taofeek')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/users', params: { name: 'taofek' } }

      it 'returns creation status as false' do
        expect(json['created']).to match(false)
      end

      it 'returns a validation failure message' do
        expect(json['error_messages'])
          .to match(["Password can't be blank", "Email can't be blank", 'Email is invalid', "Username can't be blank"])
      end
    end
  end

  describe 'POST /login' do
    context 'when user logs in with valid parameters' do
      let(:login_attributes) { { username: 'teekaytech', password: 'password' } }
      before { post '/api/v1/login', params: login_attributes }

      it 'logs in a user' do
        expect(json['user']['username']).to eq('teekaytech')
        expect(json['user']['name']).to eq('taofeek')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when user logs in with invalid parameters' do
      let(:login_attributes) { { username: 'teekaytech', password: 'pass' } }
      before { post '/api/v1/login', params: login_attributes }

      it 'returns login status as not_logged_in' do
        expect(json['status']).to match('NOT_LOGGED_IN')
      end

      it 'returns an error message' do
        expect(json['error']).to match('Invalid username or password')
      end
    end
  end

  describe 'GET /auto_login' do
    let(:login_attributes) { { username: 'teekaytech', password: 'password' } }
    context 'when the current user is not authorized' do
      before { get '/api/v1/auto_login' }

      it 'validates an un-authorized user' do
        expect(json['message']).to eq('Please log in')
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when the current user is authorized' do
      after { get '/api/v1/auto_login' }

      it 'returns the username of current user' do
        expect(json['user']['username']).to match('teekaytech')
      end
    end
  end
end
