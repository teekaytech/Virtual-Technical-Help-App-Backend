class ApplicationController < ActionController::API
  before_action :authorized

  include Response
  include ExceptionHandler

  def encode_token(payload)
    JWT.encode(payload, ENV['JWT_TOKEN'])
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    return false unless auth_header

    token = auth_header.split(' ')[1]
    begin
      JWT.decode(token, ENV['JWT_TOKEN'], true, algorithm: 'HS256')
    rescue JWT::DecodeError
      false
    end
  end

  def logged_in_user
    return false unless decoded_token

    user_id = decoded_token[0]['user_id']
    @user = User.select(:id, :name, :username, :email).find_by(id: user_id)
  end

  def logged_in?
    return true if logged_in_user

    false
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end
