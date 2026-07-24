class DashboardsController < ApplicationController
  def index
  end

  def hospitals
    @hospitals = Hospital.all
  end

  def patients
    @patients = Patient.all
  end

  def doctors
    @doctors = Doctor.all
  end

  def profiles
    @profiles = Profile.all
  end

  def appointments
    @appointment = Appointment.all
  end
end
