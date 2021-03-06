require_relative 'month.rb'
# A container for 12 month objects
class Year
  attr_reader :year
  attr_reader :months
  def initialize(in_year)
    in_year ||= Date.today.year
    @year = in_year
    @months = (1..12).map { |m| Month.new(year, m) }
  end

  def weekday_headers
    %w[Su Mo Tu We Th Fr Sa]
  end

  def leap_year?
    (@year % 4).zero?
  end
end
