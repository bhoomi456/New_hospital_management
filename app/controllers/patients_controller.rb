class PatientsController < ApplicationController
  before_action :set_patient, only: [ :show, :edit, :update, :destroy ]

  def index
    @patients = Patient.all
    @patients_count = Patient.count
  end

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(patient_params)
    if @patient.save
      @patients_count = Patient.count
      respond_to do |format|
        format.turbo_stream
      end
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
      respond_to do |format|
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @patient.destroy
      @patients_count = Patient.count
      respond_to do |format|
        format.turbo_stream
      end
    else
      redirect_to patients_path, notice: "Patient not found"
    end
  end

  def search
    @patients = Patient.where("name LIKE ?", "%#{params[:q]}%")

    render json: @patients
  end

  def export
    @patients = Patient.all
    csv_data = CSV.generate(headers: true) do |csv|
      csv << [ "name", "age", "gender", "phone" ]
      @patients.each do |patient|
        csv << [
          patient.name,
          patient.age,
          patient.gender,
          patient.phone
        ]
      end
    end
    send_data csv_data, filename: "patients.csv", type: "text/csv"
  end


  private
  def patient_params
    params.require(:patient).permit(:name, :age, :gender, :phone)
  end

  def set_patient
    @patient = Patient.find(params[:id])
  end
end
