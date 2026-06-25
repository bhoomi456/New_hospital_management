class HospitalController < ApplicationController
  def index
    @hospital = Hospital.all
  end
end