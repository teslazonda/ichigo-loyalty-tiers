# seeds.rb

# Ensure that Faker gem is included in your Gemfile and installed
# gem 'faker'

# Clear existing data
puts "Deleting all orders..."
Order.destroy_all

# Seed orders with Faker data
5.times do
  Order.create!(
    customerId: Faker::Number.number(digits: 3).to_s,
    customerName: Faker::JapaneseMedia::OnePiece.character,
    orderId: "T#{Faker::Alphanumeric.alphanumeric(number: 3).upcase}",
    totalInCents: Faker::Number.number(digits: 4),
    date: Faker::Time.between(from: 1.year.ago, to: Time.now, format: :iso8601)
  )
end

puts "Seeding complete!"
