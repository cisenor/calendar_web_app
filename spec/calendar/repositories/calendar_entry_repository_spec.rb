require_relative '../../spec_helper'

describe CalendarEntryRepository do
  let(:repo) { CalendarEntryRepository.new }

  # place your tests here
  it 'returns a :holiday style tag for holidays' do
    repo.clear
    repo.create(name: 'Christmas', month: 12, day: 25, holiday: 1)
    style = repo.style(Date.new(2000, 12, 25))
    style.must_equal :holiday

    style = repo.style(Date.new(2022, 12, 25))
    style.must_equal :holiday
  end

  it 'returns a :friday13 tag on a Friday the 13th' do
    repo.clear
    style = repo.style(Date.new(2018, 4, 13))
    style.must_equal :friday13
    style = repo.style(Date.new(2018, 4, 14))
    style.must_equal :none
  end

  it 'can check occurrence properly' do
    repo.clear
    easter = repo.create(name: 'Easter', month: 4, occurrence_week: 1, occurrence_weekday: 1)
    edate = easter.date 2018
    style_tag = repo.style(edate)
    assert style_tag == :holiday, 'expected holiday, got ' + style_tag.to_s
  end

  it 'can check occurrence properly with 0th weekday' do
    repo.clear
    easter = repo.create(name: 'Easter', month: 4, occurrence_week: 1, occurrence_weekday: 0)
    edate = easter.date 2024
    style_tag = repo.style(edate)
    assert style_tag == :holiday, 'expected holiday, got ' + style_tag.to_s
  end

  it 'sorts calendar entries by date' do
    repo.clear
    e2 = repo.create(name: 'Easter2', month: 4, occurrence_week: 1, occurrence_weekday: 1)
    nye = repo.create(name: 'New Year\'s Eve', month: 12, day: 31)
    e1 = repo.create(name: 'Easter1', month: 4, occurrence_week: 1, occurrence_weekday: 1)
    boxing = repo.create(name: 'Boxing Day', month: 12, day: 26)
    nyday = repo.create(name: 'New Year\'s day', month: 1, day: 1)
    christmas = repo.create(name: 'Christmas', month: 12, day: 25)
    sorted = repo.sorted(2018)
    sorted.must_equal [nyday, e1, e2, christmas, boxing, nye]
  end

  it 'returns a calendar entry when provided a date object' do
    repo.clear
    nye = repo.create(name: 'New Year\s Eve', month: 12, day: 31)
    nye_date = Date.new(2018, 12, 31)
    entries = repo.entry_by_date(nye_date)
    entries.wont_be_empty
    entries.first.month.must_equal nye.month
    entries.first.day.must_equal nye.day
  end
end
