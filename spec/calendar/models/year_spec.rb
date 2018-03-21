require_relative '../../spec_helper'
require_relative '../../../lib/calendar/models/year'

describe 'Test year creation' do
  it 'creates properly' do
    year = Year.new(2000)
    year.months.size.must_equal 12
    year.months[1].name.must_equal 'February'
    year.months[1].last_day.must_equal 28
  end

  it 'creates a leap year properly' do
    no_leap = Year.new(2001)
    leap = Year.new(2000)
    no_leap.leap_year?.must_equal false
    no_leap.months[1].last_day.must_equal 28
    leap.leap_year?.must_equal true
    leap.months[1].last_day.must_equal 29
  end
end
