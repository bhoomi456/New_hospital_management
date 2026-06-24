class DoctorsController < ApplicationController
  def index
    @doctors = Doctor.all
  end

  def new
    @doctor = Doctor.new
  end

  def create
    @doctor = Doctor.new(doctor_params)
    if @doctor.save
      redirect_to doctors_path, notice: "Doctor Added successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def doctor_params
    params.require(:doctor).permit(:name, :specialization)
  end
end