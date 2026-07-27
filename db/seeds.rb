# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
TOTAL = 3000000
BATCH_SIZE = 300

hospitals = []


TOTAL.times do
  hospitals << Hospital.new(
    name: "#{Faker::City.name} Hospital",
    admin_email: Faker::Internet.unique.email,
    address: Faker::Address.full_address
  )

  if hospitals.size == BATCH_SIZE
    Hospital.import(hospitals)
    hospitals.clear
  end
end

Hospital.import(hospitals) if hospitals.any?