class DoctorsController < ApplicationController
  before_action :set_doctor, only: [:show, :edit, :update, :destroy]

  def index
    @doctors = Doctor.all
  end

  def new
    @doctor = Doctor.new
    @doctor.build_profile
  end

  def edit
  end

  def create
    @doctor = Doctor.new(doctor_params)
    if @doctor.save
      respond_to do |format|
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @appointment = @doctor.appointments.find(params[:id])
  end

  def destroy
    if @doctor.destroy
      respond_to do |format|
        format.turbo_stream
      end
    else
      redirect_to patients_path, notice: "Patient not found"
    end
  end

  def update
    if @doctor.update(doctor_params)
      respond_to do |format|
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

   def search
    @doctors = Doctor.where("name LIKE ?", "%#{params[:q]}%")

    render json: @doctors
  end


  private
  def doctor_params
    params.require(:doctor).permit(:name, :specialization, :hospital_id, profile_attributes: [:experience,
      :consultation_fee])
  end

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end
end