require 'features_helper'

describe 'Add a new date' do
  let(:repo)      { CalendarEntryRepository.new }
  let(:user_repo) { UserRepository.new }
  def before_setup
    repo.clear
    user_repo.clear
  end

  describe 'Fixed date' do
    it 'can create a new fixed date' do
      login_as get_test_user
      visit '/'
      click_link 'Add a date' 
      within 'form#calendar_entry_fixed-form' do
        fill_in 'Name', with: 'Chrimbo'
        select 'December', from: 'Month'
        fill_in 'Day', with: 25
        click_button 'Add fixed date'
      end
      current_path.must_equal '/'
      assert page.has_content? '2018-12-25 - Chrimbo'
    end

    it 'displays a list of errors when params contains errors' do
      visit '/dates/add'
      within 'form#calendar_entry_fixed-form' do
        click_button 'Add'
      end

      current_path.must_equal '/dates'
      assert page.has_content? 'There was a problem with your submission'
      assert page.has_content? 'Name must be filled'
    end
  end

  describe 'Occurrence Date' do
    it 'can create a new occurrence-based date' do
      visit '/dates/add'
      within 'form#calendar_entry_occurrence-form', visible: false do
        fill_in 'Name', with: 'Easter', visible: false
        select 'April', from: 'Month', visible: false
        fill_in 'Occurrence week', with: 1, visible: false
        select 'Monday', from: 'Occurrence weekday', visible: false
        click_button 'Add date', visible: false
      end
      assert page.status_code == 200
      current_path.must_equal '/'
      assert page.has_content? '2018-04-02 - Easter'

      easter_xpath = '/html/body/div[2]/div[1]/div/div[4]/div[3]/a[2]'
      assert find(easter_xpath)[:class].include?('holiday')
    end
  end
end
