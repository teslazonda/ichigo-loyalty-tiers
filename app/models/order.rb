class Order < ApplicationRecord
  belongs_to :customer, touch: true

  after_save :recalculate_customer_attributes_after_create
  after_create :invalidate_customer_cache


  validates :customer_id, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :customerName, presence: true
  validates :orderId, presence: true, uniqueness: { case_sensitive: false, message: 'must be unique and start with "T" followed by numerical characters' }, format: { with: /\AT\d+\z/, message: 'must start with "T" followed by numerical characters' }, length: { maximum: 50 }
  validates :totalInCents, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :date, presence: true

  validate :date_format_must_be_iso8601
  before_validation :convert_customer_id_to_string


  private
  def invalidate_customer_cache
    customer&.touch # Touch the associated customer to update its cache key
  end

  def recalculate_customer_attributes_after_create
    customer.recalculate_attributes # Call a method in Customer model to recalculate attributes
    "****** Attributes recalculated!"
  end

  def convert_customer_id_to_string
    self.customerId = customer_id.to_s if customer_id.present?
  end

  def customer_id_matches_customerId
    errors.add(:customerId, 'must be the string version of customer_id') unless customerId.strip.downcase == customer_id.to_s.strip.downcase
  end

  def date_format_must_be_iso8601
      iso8601_regex = /\A\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}Z\z/

      begin
        parsed_date = Time.parse(date.to_s)
        formatted_date = parsed_date.utc.iso8601(3)

        unless formatted_date =~ iso8601_regex
          errors.add(:date, 'must be a valid ISO 8601 formatted date with milliseconds')
        end
      rescue ArgumentError
        errors.add(:date, 'must be a valid date')
      end
    end
end
