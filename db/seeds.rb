# Clear existing data
puts "Deleting all orders and customers..."
Order.destroy_all
Customer.destroy_all

# Create a customer (Taro Suzuki)
customer = Customer.create!(
  current_tier: 'SILVER',
  amount_spent_since_last_year: 10000,
  amount_needed_for_next_tier: 40000,
  downgraded_tier: 'BRONZE',
  amount_needed_to_avoid_downgrade: 0,
  name: "Taro Suzuki"
)

# Seed orders with Faker data, associating each order with the customer
50.times do
  order_id_prefix = "T"
  order_id_suffix = nil
  # order_id = "#{order_id_prefix}#{order_id_suffix}"

  loop do
    order_id_suffix = Faker::Number.number(digits: 3)
    break unless Order.exists?(orderId: "#{order_id_prefix}#{order_id_suffix}")
  end

  order_id = "#{order_id_prefix}#{order_id_suffix}"

  customer.orders.create!(
    customerId: (customer.id.to_s if customer.id.present?),
    customerName: customer.name,
    orderId: order_id,
    totalInCents: Faker::Number.number(digits: 4),
    date: Faker::Time.between(from: 1.year.ago, to: Time.now, format: :iso8601),
    customer: customer
  )
end

puts "Seeding complete!"
