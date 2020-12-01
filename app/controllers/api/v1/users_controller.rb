class Api::V1::UsersController < ApplicationController
  before_action :authorized, only: [:auto_login]

  def create
    @user = User.create(user_params)
    if @user.valid?
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token, created: true }, status: :created
    else
      render json: { created: false, error_messages: @user.errors.full_messages }
    end
  end

  def login
    @user = User.find_by(username: params[:username])

    check_auth = @user.authenticate(params[:password])
    if @user && check_auth
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token, logged_in: true }, status: :ok
    else
      render json: { error: 'Invalid username or password', status: 'NOT_LOGGED_IN' }
    end
  end

  def auto_login
    if logged_in_user
      render json: { logged_in: true, user: logged_in_user }
    else
      render json: { message: 'No user is currently logged in' }
    end
  end

  def logout
    reset_session
    render json: { logged_out: true }, status: :ok
  end

  private

  def user_params
    params.permit(:name, :username, :email, :password, :password_confirmation)
  end
end
