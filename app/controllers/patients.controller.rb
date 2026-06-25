class PatientsController < ApplicationController
  def index
    @patients = Patient.all
  end

  def new
    @doctor = Doctor.new
  end

  def create
    @patient = Patient.new(patient_params)
    if @patient.save
      redirect_to patients_path, notice: "Patient Added Successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  private
  def patient_params
    params.require(:patient).permit(:name, :age, :gender)
  end
end
