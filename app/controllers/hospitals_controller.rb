class HospitalsController < ApplicationController
  before_action :set_hospital, only: [:show]
  def index
    @hospitals = Hospital.all
  end

  def new
    @hospital = Hospital.new 
  end

  def create
    @hospital = Hospital.create(hospital_params)
    if @hospital.save
      redirect_to hospitals_path, notice: "Hospital Added Successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  private

  def hospital_params
    params.require(:hospital).permit(:name)
  end

  def set_hospital
    @hospital = Hospital.find(params[:id])
  end
end