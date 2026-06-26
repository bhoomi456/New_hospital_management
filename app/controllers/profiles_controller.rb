class ProfilesController < ApplicationController
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
  
  private

  def profile_params
    params.require(:profile).permit(:consultation_fee, :doctor_id, :experience)
  end
end