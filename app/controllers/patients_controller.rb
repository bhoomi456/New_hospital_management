class PatientsController < ApplicationController
  require "csv"
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
      flash.now[:alert] = "Could not add Patient: #{@patient.errors.full_messages.join(', ')}"

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

  def search
    @patients = Patient.where("name LIKE ?", "%#{params[:q]}%")

    render json: @patients
  end

  def export
    @patients = Patient.all
    csv_data = CSV.generate(headers: true) do |csv|
      csv << ["name","age","gender","phone"]
      @patients.each do |patient|
        csv << [
          patient.name,
          patient.age,
          patient.gender,
          patient.phone,
        ]
      end
    end
    send_data csv_data,filename: "patients.csv",type: "text/csv"
  end

  
  private
  def patient_params
    params.require(:patient).permit(:name, :age, :gender, :phone)
  end

  def set_patient
    @patient = Patient.find(params[:id])
  end
end
