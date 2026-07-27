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
BATCH_SIZE = 30000
imported_count = 0

hospitals = []
start_time = Time.now

TOTAL.times do
  hospitals << Hospital.new(
    name: "#{Faker::Address.city} Hospital",
    admin_email: Faker::Internet.unique.email,
    address: Faker::Address.full_address
  )

  if hospitals.size == BATCH_SIZE
    batch_start = Time.now

    Hospital.import(hospitals)
    batch_end = Time.now
    imported_count += hospitals.size
    puts "Imported #{imported_count} hospitals | Batch Time: #{batch_end - batch_start} sec"
    hospitals.clear
  end
end

Hospital.import(hospitals) if hospitals.any?
puts "Total Time: #{Time.now - start_time} sec"
