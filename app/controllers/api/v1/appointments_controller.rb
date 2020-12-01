class Api::V1::AppointmentsController < ApplicationController
  skip_before_action :authorized
  before_action :set_appointment, only: %i[show update destroy]

  def index
    @appointments = Appointment.all
    json_response(@appointments)
  end

  def create
    @appointment = Appointment.create!(appointment_params)
    json_response(@appointment, :created)
  end

  def show
    json_response(@appointment)
  end

  def update
    @appointment.update(appointment_params)
    head :no_content
  end

  def destroy
    @appointment.destroy
    head :no_content
  end

  private

  def appointment_params
    params.permit(:user_id, :engineer_id, :date, :duration, :status)
  end

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end
end
