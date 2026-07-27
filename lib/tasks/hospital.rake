namespace :hospital do
  desc "Generate hospitals records"
  task generate_records: :environment do
    total = 3_000_000
    batch_size = 30000
    batches = total / batch_size

    start_time = Time.now
    batches.times do |batch|
      hospitals = []
      batch_size.times do
        hospitals << Hospital.new(
          name: "#{Faker::Company.name} Hospital",
          admin_email: Faker::Internet.email,
          address: Faker::Address.full_address
        )
      end
      start_batch_time = Time.now
      Hospital.import(hospitals)
      puts "Total recordds imported: #{(batch + 1) * batch_size}. Time taken for this batch: #{Time.now - start_batch_time} seconds"
    end
    puts "Total time taken  #{Time.now - start_time} seconds"
  end
end