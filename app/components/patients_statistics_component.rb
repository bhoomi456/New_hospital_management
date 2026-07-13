class PatientsStatisticsComponent < ViewComponent::Base 
  def initialize(patients:)
    @patients = patients
  end

  def total_patients
    @patients.count 
  end

  def total_male_patients
    @patients.where(gender: "Male").count
  end

  def total_female_patients
    @patients.where(gender: "Female").count
  end
end