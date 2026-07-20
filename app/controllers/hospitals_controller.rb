class HospitalsController < ApplicationController
  before_action :set_hospital, only: [:show, :edit, :update, :destroy]
  def index
    @hospitals = Hospital.all
    # respond_to do |format|
    #   format.html
    #   format.json { render json: @hospitals }
    #   # format.xml  { render xml: @hospitals }
    # end
  end

  def new
    @hospital = Hospital.new 
  end

  def create
    @hospital = Hospital.new(hospital_params)
    if @hospital.save
      respond_to do |format|
        format.turbo_stream
        format.html do
          redirect_to hospitals_path,notice: "Hospital Added Successfully"
        end
      end
      # redirect_to hospitals_path, notice: "Hospital Added Successfully", status: 301
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    cookies.signed[:last_hospital] = @hospital.id
  end

  def edit 
  end

  def update
    if @hospital.update(hospital_params)
      respond_to do |format|
        format.turbo_stream
        format.html do
          redirect_to hospitals_path
        end
      end
    else
      render :edit, status: :unprocessable_entity 
    end
  end  
  
  def destroy
    @hospital.destroy

    # redirect_to hospitals_path, notice: "Hosptial Deleted Successfully"
    respond_to do |format|
      format.turbo_stream
      format.html do
        redirect_to hospitals_path, notice: "Hospital deleted successfully."
      end
    end
  end

  private

  def hospital_params
    params.require(:hospital).permit(:name)
  end

  def set_hospital
    @hospital = Hospital.find(params[:id])
  end
end