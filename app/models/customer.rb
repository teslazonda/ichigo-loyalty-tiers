class Customer < ApplicationRecord
  has_many :orders

  validates :current_tier, presence: true
  validates :amount_spent_since_last_year, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :amount_needed_for_next_tier, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :downgraded_tier, inclusion: { in: ['BRONZE', 'SILVER', 'GOLD'], allow_blank: true }
  validates :amount_needed_to_avoid_downgrade, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :name, presence: true, length: { maximum: 100 }
end
