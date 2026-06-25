class PatientsController < ApplicationController
  before_action :set_patient, only: [:show]
  
  def index
    @patients = Patient.all
  end

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(patient_params)
    if @patient.save
      redirect_to patients_path, notice: "Patient Added Successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def show
  end
  
  private
  def patient_params
    params.require(:patient).permit(:name, :age, :gender)
  end

  def set_patient
    @patient = Patient.find(params[:id])
  end
end
