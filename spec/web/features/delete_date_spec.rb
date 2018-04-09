require 'features_helper'

describe 'Delete dates' do
  let(:repo)      { CalendarEntryRepository.new }
  let(:user_repo) { UserRepository.new }

  def before_setup
    repo.clear
    user_repo.clear
  end

  it 'can delete an entry' do
    entry = create_public_entry
    visit '/'
    assert page.has_css?('#entry-list')
    assert page.find("#delete-entry-#{entry.id}", count: 1)
    page.find("#delete-entry-#{entry.id}").click
    visit '/'
    assert page.has_no_css?('#entry-list')
  end
end
