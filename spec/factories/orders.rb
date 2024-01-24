FactoryBot.define do
  factory :order do
    customerId { "MyString" }
    customerName { "MyString" }
    orderId { "MyString" }
    totalInCents { 1 }
    date { "2024-01-24 20:36:48" }
  end
end
