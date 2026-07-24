class HospitalsController < ApplicationController
  before_action :set_hospital, only: [ :show, :edit, :update, :destroy ]
  def index
    @hospitals = Hospital.page(params[:page]).per(20)
  end

  def new
    @hospital = Hospital.new
  end

  def create
    @hospital = Hospital.new(hospital_params)
    if @hospital.save
      @hospitals_count = Hospital.count
      respond_to do |format|
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # cookies.signed[:last_hospital] = @hospital.id
  end

  def edit
  end

  def update
    if @hospital.update(hospital_params)
      HospitalMailer.hospital_updated(@hospital).deliver_now
      respond_to do |format|
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @hospital.destroy
      @hospitals_count = Hospital.count
      respond_to do |format|
        format.turbo_stream
      end
    else
      redirect_to hospitals_path, notice: "Hospital not found"
    end
  end

  private

  def hospital_params
    params.require(:hospital).permit(:name, :admin_email, :address)
  end

  def set_hospital
    @hospital = Hospital.find(params[:id])
  end
end
