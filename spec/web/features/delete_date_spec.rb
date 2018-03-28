require 'features_helper'

describe 'Delete dates' do
  let(:repo) { CalendarEntryRepository.new }
  it 'can delete an entry' do
    repo.clear
    repo.create(name: 'Christmas', month: 12, day: 25)
    visit '/'
    assert page.has_css?('#entry-list')
    p page.find('#entry-list').native
    assert page.find('#entry-list li', count: 1),
           'Did not find one entry, found ' + page.find('#entry-list').all('li').size.to_s
    page.find('#entry-list > li > a').click
    visit '/'
    assert page.has_no_css?('#entry-list'),
           'Found the entry list when there should not be one.'
  end
end
