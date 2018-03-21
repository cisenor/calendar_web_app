require_relative '../../spec_helper'

describe CalendarEntry do
  it 'can be created with concrete day & month' do
    entry = CalendarEntry.new(name: 'Chrimbo', month: 12, day: 25)
    entry.name.must_equal 'Chrimbo'
    entry.month.must_equal 12
    entry.day.must_equal 25
  end
  describe 'can be created with week and weekday occurrence' do
    entry = CalendarEntry.new(name: 'Easter', month: 4, occurrence_week: 1, occurrence_weekday: 1)
  end
end
