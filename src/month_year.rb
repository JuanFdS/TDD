require 'date'

class MonthYear
  include Comparable
  attr_reader :year, :month

  def <=>(other)
    Date.new(year, month, 1) <=> Date.new(other.year, other.month, 1)
  end
  def self.from_date(date)
    new(date.year , date.month)
  end
  def initialize(year, month)
    raise ArgumentError, 'Invalid Month Year' unless Date.valid_date?(year, month, 1)
    @year = year
    @month = month
  end
end
