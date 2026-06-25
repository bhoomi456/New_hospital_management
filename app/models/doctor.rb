class Doctor < ApplicationRecord
  belongs_to :hospital
  has_many :appointments
  has_many :patients, through: :appointments
  has_one :doctor_profile
end
