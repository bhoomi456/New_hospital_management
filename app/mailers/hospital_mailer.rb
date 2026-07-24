class HospitalMailer < ApplicationMailer
  def hospital_updated(hospital)
    @hospital = hospital
    mail(to: @hospital.admin_email, 
      subject: "Hospital details updated",
      body: "The hospital details have been updated."
    )
  end
end