require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe '#calculate_amount_spent_since_last_year' do
    it 'calculates the amount spent since last year' do
      customer = create(:customer)
      puts "******"
      p customer

      # Create orders with dates within the last year
      within_last_year_order = create(:order, customer: customer, date: 6.months.ago, orderId: 'T123')
      p within_last_year_order
      current_year_order = create(:order, customer: customer, date: Time.current, orderId: 'T124')

      # within_last_year_order = create(:order, customer: customer, date: 6.months.ago)
      # current_year_order = create(:order, customer: customer, date: Time.current)

      # Order with a date older than last year
      older_order = create(:order, customer: customer, date: 2.years.ago,  orderId: 'T125')

      # Calculate the expected amount spent since last year
      expected_amount_spent = (within_last_year_order.totalInCents + current_year_order.totalInCents) / 100.0

      # Call the method to calculate the actual amount spent
      actual_amount_spent = customer.calculate_amount_spent_since_last_year

      # Check if the calculated amount matches the expected amount
      puts "-------------------------------------------"
      puts actual_amount_spent
      expect(actual_amount_spent).to eq(expected_amount_spent)
    end
  end
end
