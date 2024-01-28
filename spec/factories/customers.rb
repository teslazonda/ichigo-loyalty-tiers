FactoryBot.define do
  factory :customer do
    name { Faker::Name.name }
    current_tier { 'SILVER' } # Set the default tier value, adjust as needed
    amount_spent_since_last_year { 0 }
    amount_needed_for_next_tier { 400 }
    downgraded_tier { 'BRONZE' }
    amount_needed_to_avoid_downgrade { 100 }
  end
end
