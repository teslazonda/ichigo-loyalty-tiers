FactoryBot.define do
  factory :customer do
    name { Faker::Name.name }
    amount_spent_since_last_year { Faker::Number.between(from: 0, to: 1000000) }

    transient do
      order_count { 50 } # Adjust the number of associated orders as needed
    end

    after(:create) do |customer, evaluator|
      create_list(:order, evaluator.order_count, customer: customer, date: Faker::Time.between(from: 2.years.ago, to: Time.current, format: :iso8601))
      puts "Customer #{customer.id} - Amount spent since last year: #{customer.amount_spent_since_last_year}"

      if customer.amount_spent_since_last_year >= 50001
        customer.with_gold_tier
      elsif customer.amount_spent_since_last_year >= 10001
        customer.with_silver_tier
      else
        customer.with_bronze_tier
      end

      customer.recalculate_attributes
    end

    trait :with_gold_tier do
      current_tier { 'GOLD' }
      amount_spent_since_last_year { Faker::Number.between(from: 50001, to: 10000000000000) }
    end

    trait :with_silver_tier do
      current_tier { 'SILVER' }
      amount_spent_since_last_year { Faker::Number.between(from: 10001, to: 50000) }
    end

    trait :with_bronze_tier do
      current_tier { 'BRONZE' }
      amount_spent_since_last_year { Faker::Number.between(from: 0, to: 10000) }
    end
  end
end
