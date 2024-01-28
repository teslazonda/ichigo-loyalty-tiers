require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validations' do
    it { should belong_to(:customer) }

    it { should validate_presence_of(:customer_id) }
    it { should validate_numericality_of(:customer_id).is_greater_than_or_equal_to(0) }

    it { should validate_presence_of(:customerName) }

    it { should validate_presence_of(:orderId) }
    #it { should validate_uniqueness_of(:orderId) }
it 'validates case-sensitive uniqueness of orderId' do
      customer = create(:customer)
      existing_order = create(:order, orderId: 'T123', customer: customer)

      # note that validations are not triggered by the #build method
      order = build(:order, orderId: 't123', customer: customer)

      expect(order).not_to be_valid
      expect(order.errors[:orderId]).to include('must be unique and start with "T" followed by numerical characters')
    end
    it { should allow_value('T123').for(:orderId) }
    it { should_not allow_value('123').for(:orderId).with_message('must start with "T" followed by numerical characters') }
    it { should validate_length_of(:orderId).is_at_most(50) }

    it { should validate_presence_of(:totalInCents) }
    it { should validate_numericality_of(:totalInCents).is_greater_than_or_equal_to(0) }

    it { should validate_presence_of(:date) }

    it 'validates date format' do
      customer = create(:customer)
      order = create(:order, date: '2022-03-04T05:29:59.850Z', customer: customer)
      expect(order).to be_valid
    end

    # it 'invalidates date with wrong format' do
    #   customer = create(:customer)
    #   order = create(:order, date: 'January 1st, 2025', customer: customer)
    #   p order
    #   expect(order.valid?).to be false
    #   expect(order.errors[:date]).to include('must be a valid ISO 8601 formatted date with milliseconds')
    # end
  end

  describe 'callbacks' do
    it 'converts customer_id to string before validation' do
      order = build(:order, customer_id: 123)
      order.valid?
      expect(order.customerId).to eq('123')
    end
  end

# describe 'custom validations' do
#   it 'ensures customerId matches customer_id' do
#     customer = create(:customer)
#     order = create(:order, customer_id: customer.id, customerId: customer.id.to_s)
#     puts "before"
#     p order
#     order.valid?
#     order.send(:convert_customer_id_to_string)
#     if order.save
#       puts "Order saved successfully"
#     else
#       puts "Order save failed"
#       puts order.errors.full_messages
#     end
#     expect(order.save).to be true

#     order.customerId = '456' # Set the customerId to be different from customer_id
#     puts "#{order.customerId} this is the &&&&&&&&&&&&&&"
#     #order.send(:convert_customer_id_to_string)
#     puts "after"
#     p order
#     if order.save
#       puts "Order saved successfully"
#     else
#       puts "Order save failed"
#       puts order.errors.full_messages
#     end
#     order.valid?
#     expect(order.save).to be false
#     #order.valid?
#     # puts order.errors[:customerId]
#     expect(order.errors[:customerId]).to include('must be the string version of customer_id')
#   end
# end
end
