class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
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

  def edit 
  end

  def update
    if @profile.update(profile_params)
      redirect_to profiles_path, notice: "Profile Updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @profile.destroy

    redirect_to profiles_path, notice: "Profile Deleted Successfully"
  end
  
  private

  def profile_params
    params.require(:profile).permit(:consultation_fee, :doctor_id, :experience)
  end

  def set_profile
    @profile = Profile.find(params[:id])
  end
end