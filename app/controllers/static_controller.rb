class StaticController < ApplicationController
  before_action :authorized, only: [:auto_login]
  def index
    render json: { mesage: 'Welcome!' }
  end
end
