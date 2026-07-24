class HospitalMailer < ApplicationMailer
  def hospital_updated(hospital)
    @hospital = hospital

    changes = @hospital.previous_changes

    mail(to: @hospital.admin_email,
      subject: "Hospital details updated",
      body: "Name: #{changes['name'][0]} <- Updated To -> #{changes['name'][1]}\n" \
            "Address: #{changes['address'][0]} <- Updated To -> #{changes['address'][1]}"
    )
  end
end
