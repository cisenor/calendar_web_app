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
end
