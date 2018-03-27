require 'date'
##
# Maintains a list of weeks / days
class Month
  attr_reader :year
  attr_reader :name
  attr_reader :last_day
  attr_reader :weeks
  attr_reader :month
  def initialize(year, month)
    @year = year
    @month = month
    # -1 in the day parameter will return the last day
    d = Date.civil(@year, @month, -1)
    @last_day = d.day
    @name = Date::MONTHNAMES[@month]
    @weeks = create_weeks
  end

  ##
  # Whether the provided day is valid for this month
  def valid_day?(day)
    day.to_i <= @last_day && day.to_i >= 1
  end

  def to_s
    @name
  end

  private

  def create_weeks
    weeks = []
    days = (1..@last_day).map { |day| Date.new(@year, @month, day) }
    weeks << create_first_week(days)
    weeks << days.shift(7) until days.empty?
    weeks
  end

  def create_first_week(days)
    week_start = days.first.wday
    (0..6).map do |day|
      days.shift if day >= week_start
    end
  end
end
