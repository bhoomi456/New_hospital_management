class DoctorsController < ApplicationController
  before_action :set_doctor, only: [:show]
  
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

  def show
  end

  private
  def doctor_params
    params.require(:doctor).permit(:name, :specialization)
  end

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end
end