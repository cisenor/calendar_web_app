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

  it 'displays a list of errors when params contains errors' do
    visit '/dates/add'
    within 'form#calendar_entry-form' do
      click_button 'Add'
    end
    
    current_path.must_equal '/dates'
    assert page.has_content? 'There was a problem with your submission'
    assert page.has_content? 'Name must be filled'
  end
end
