class HospitalsController < ApplicationController
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

  private

  def hospital_params
    params.require(:hospital).permit(:name)
  end
end