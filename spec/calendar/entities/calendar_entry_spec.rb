require_relative '../../spec_helper'

describe CalendarEntry do
  christmas = CalendarEntry.new(name: 'Chrimbo', month: 12, day: 25)
  easter = CalendarEntry.new(name: 'Easter', month: 4, occurrence_week: 1, occurrence_weekday: 1)
  thanksgiving = CalendarEntry.new(name: 'Thanksgiving', month: 10, occurrence_week: 2, occurrence_weekday: 1)
  it 'can be created with concrete day & month' do
    christmas.name.must_equal 'Chrimbo'
    christmas.month.must_equal 12
    christmas.day.must_equal 25
  end
  it 'can be created with week and weekday occurrence' do
    easter.name.must_equal 'Easter'
    easter.month.must_equal 4
    easter.occurrence_week.must_equal 1
    easter.occurrence_weekday.must_equal 1
  end
  it 'can return date object' do
    christmas.date(2015).must_equal Date.new(2015, 12, 25)
    easter.date(2018).must_equal Date.new(2018, 4, 2)
    thanksgiving.date(2018).must_equal Date.new(2018, 10, 8)
    thanksgiving.date(2017).must_equal Date.new(2017, 10, 9)
  end
end
