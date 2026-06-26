class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]

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

  def show 
  end

  def edit 
  end

  def update
    if @appointment.update(appointment_params)
      redirect_to appointments_path, notice: "Appointment Updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end 
  
  def destroy
    @appointment.destroy

    redirect_to appointments_path, notice: "Appointment deleted successfully"
  end
  
  private

  def appointment_params
    params.require(:appointment).permit(:reason, :doctor_id, :patient_id, :appointment_date)
  end

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end
end