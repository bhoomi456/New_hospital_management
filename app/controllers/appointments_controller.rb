class AppointmentsController < ApplicationController
  def index
    @appointments = Appointment.all
  end

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      redirect_to appointments_path, notice: "Appointment Added successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end 
  
  private

  def appointment_params
    params.require(:appointment).permit(:reason, :doctor_id, :patient_id, :appointment_date)
  end
end