class DoctorsController < ApplicationController
  before_action :set_doctor, only: [:show, :edit, :update, :destroy]

  def index
    @doctors = Doctor.all
    @doctors_count = Doctor.count
  end

  def new
    @doctor = Doctor.new
    @doctor.build_profile
  end

  def edit
    @doctor.build_profile unless @doctor.profile
  end

  def create
    @doctor = Doctor.new(doctor_params)
    if @doctor.save
      @doctors_count = Doctor.count
      respond_to do |format|
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def destroy
    if @doctor.destroy
      @doctors_count = Doctor.count
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
    params.require(:doctor).permit(:name, :specialization, :hospital_id, profile_attributes: [:id, :experience,
      :consultation_fee])
  end

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end
end