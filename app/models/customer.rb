class Customer < ApplicationRecord
  has_many :orders

  # validates :current_tier, presence: true
  # validates :amount_spent_since_last_year, presence: true, numericality: { greater_than_or_equal_to: 0 }
  # validates :amount_needed_for_next_tier, presence: true, numericality: { greater_than_or_equal_to: 0 }
  # validates :downgraded_tier, inclusion: { in: ['BRONZE', 'SILVER', 'GOLD'], allow_blank: true }
  # validates :amount_needed_to_avoid_downgrade, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :name, presence: true, length: { maximum: 100 }

  def calculate_amount_spent_since_last_year
    # Logic to calculate the amount spent since last year based on associated orders
    start_of_year = Time.current.beginning_of_year
    total_spent_last_year = orders.where('date >= ?', start_of_year).sum(:totalInCents)
    total_spent_last_year
  end

  def amount_spent_since_last_year
    calculate_amount_spent_since_last_year
  end

 def calculate_tier
    if amount_spent_since_last_year >= 50000 # Amount in cents
      puts "GOLD"
      puts amount_spent_since_last_year
      'GOLD'
    elsif amount_spent_since_last_year >= 10000
      puts "SILVER"
      puts amount_spent_since_last_year
      'SILVER'
    else
      puts "BRONZE"
      puts amount_spent_since_last_year
      'BRONZE'
    end
  end

  def amount_spent_since_last_year
    orders_in_last_year.sum(:totalInCents)
  end

  def amount_needed_for_next_tier
    calculate_tier_threshold(current_tier) - amount_spent_since_last_year
  end

  def amount_needed_to_avoid_downgrade
    calculate_tier_threshold(downgraded_tier) - amount_spent_since_last_year if downgraded_tier.present?
  end


   def calculate_tier_threshold(tier)
    # Your logic to determine the threshold for the next tier
    case tier
    when 'BRONZE'
      10000
    when 'SILVER'
      50000
    when 'GOLD'
      Float::INFINITY
    else
      0
    end
  end

  def orders_in_last_year
    start_of_year = Time.current.beginning_of_year
    orders.where('date >= ?', start_of_year)
  end

  def recalculate_attributes
    # Logic to recalculate relevant attributes based on orders
    update(
      current_tier: calculate_tier,
      amount_spent_since_last_year: calculate_amount_spent_since_last_year,
      downgraded_tier: downgraded_tier,
      amount_needed_to_avoid_downgrade: [amount_needed_to_avoid_downgrade, 0].max,
      amount_needed_for_next_tier: amount_needed_for_next_tier
      # ... other attributes
    )
  end
end
