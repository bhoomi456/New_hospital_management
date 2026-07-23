class Doctor < ApplicationRecord
  belongs_to :hospital
  has_many :appointments
  has_many :patients, through: :appointments
  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile
end
