class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show]
  def index
    @profiles = Profile.all
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      redirect_to profiles_path, notice: "Profile Added Successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end
  
  private

  def profile_params
    params.require(:profile).permit(:consultation_fee, :doctor_id, :experience)
  end

  def set_profile
    @profile = Profile.find(params[:id])
  end
end