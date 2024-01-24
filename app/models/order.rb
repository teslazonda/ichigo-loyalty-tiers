class Order < ApplicationRecord
  validates :customerId, presence: true
  validates :customerName, presence: true
  validates :orderId, presence: true, uniqueness: true
  validates :totalInCents, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :date, presence: true

  validate :date_format_must_be_iso8601

  private


def date_format_must_be_iso8601
    iso8601_regex = /\A\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}Z\z/

    begin
      parsed_date = DateTime.parse(date.to_s)
      unless parsed_date.utc.iso8601(3) =~ iso8601_regex
        errors.add(:date, 'must be a valid ISO 8601 formatted date with milliseconds')
      end
    rescue ArgumentError
      errors.add(:date, 'must be a valid date')
    end
  end
end
