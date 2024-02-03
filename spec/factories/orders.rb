FactoryBot.define do
  factory :order do
    association :customer
    customerId { "123" }
    customerName { 'Taro Suzuki' }
    orderId { "T#{Faker::Alphanumeric.unique.alphanumeric(number: 3).upcase}" }
    #orderId { "T123" }
    totalInCents { 3450 }
    date { "2022-03-04T05:29:59.850Z" }
  end
end
