class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]
  
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

  def edit
  end

  def update
    if @patient.update(patient_params)
      redirect_to patients_path, notice: "Patient Updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @patient.destroy

    redirect_to patients_path, notice: "Patient deleted successfully"
  end

  
  private
  def patient_params
    params.require(:patient).permit(:name, :age, :gender)
  end

  def set_patient
    @patient = Patient.find(params[:id])
  end
end
