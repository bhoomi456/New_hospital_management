class PatientsController < ApplicationController
  def index
    @patients = Patient.all
  end

  def new
    @doctor = Doctor.new
  end
end
