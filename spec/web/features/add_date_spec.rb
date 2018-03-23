require 'features_helper'

describe 'Add a new date' do
  after do
    CalendarEntryRepository.new.clear
  end
  before do
    CalendarEntryRepository.new.clear
  end

  it 'can create a new fixed date' do
    visit '/dates/add'
    within 'form#calendar_entry-form' do
      fill_in 'Name', with: 'Chrimbo'
      fill_in 'Month', with: 12
      fill_in 'Day', with: 25
      click_button 'Add'
    end
    current_path.must_equal '/'
    assert page.has_content? 'Chrimbo'
  end
end
