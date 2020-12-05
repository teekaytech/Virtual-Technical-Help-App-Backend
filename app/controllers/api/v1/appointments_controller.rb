class Api::V1::AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[show update destroy]

  def index
    @appointments = logged_in_user.appointments
    return json_response(full_appointments(@appointments)) if @appointments

    error_message
  end

  def create
    @appointment = logged_in_user.appointments.create(appointment_params)
    return json_response(@appointment, :created) if @appointment.valid?

    error_message
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
    @appointment = logged_in_user.appointments.find(params[:id])
  end

  def error_message
    render json: { error: 'You have to login.', status: 'NOT_LOGGED_IN' }
  end

  def full_appointments(appointments)
    full_appointments = []
    appointments.each do |app|
      full_appointments << {
        date_created: app.created_at,
        id: app.id,
        date: app.date,
        status: app.status,
        duration: app.duration,
        engineer: app.engineer[:name],
        location: app.engineer[:location]
      }
    end
    full_appointments
  end
end
