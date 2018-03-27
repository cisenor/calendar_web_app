require 'features_helper'

describe 'Show calendar' do
  let(:year) { Year.new(2018) }
  it 'defaults to current year' do
    visit '/'
    year = page.find('#title-year').text
    assert year == '2018', 'expected 2018, got ' + year
  end

  describe 'when passed a year as a router variable' do
    it 'presents the calendar for that year' do
      visit '/2017'
      assert page.find('#title-year').text == '2017'
    end
  end
end
