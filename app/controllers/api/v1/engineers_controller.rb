class Api::V1::EngineersController < ApplicationController
  skip_before_action :authorized
  before_action :set_engineer, only: %i[show update destroy]

  def index
    @engineers = Engineer.all
    json_response(@engineers)
  end

  def create
    @engineer = Engineer.create!(engineer_params)
    json_response(@engineer, :created)
  end

  def show
    json_response(@engineer)
  end

  def update
    @engineer.update(engineer_params)
    head :no_content
  end

  def destroy
    @engineer.destroy
    head :no_content
  end

  private

  def engineer_params
    params.permit(:name, :stack, :location, :avatar_link)
  end

  def set_engineer
    @engineer = Engineer.find(params[:id])
  end
end
