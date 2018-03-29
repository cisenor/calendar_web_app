require_relative '../../../spec_helper'

describe Web::Views::Home::Index do
  let(:repo)      { CalendarEntryRepository.new }
  let(:exposures) do
    Hash[
      year: Year.new(2018),
      formatter: FormatFactory.new.create(''),
      entry_list: CalendarEntryRepository.new,
      format: 'html'
    ]
  end
  let(:template)  { Hanami::View::Template.new('apps/web/templates/home/index.html.erb') }
  let(:view)      { Web::Views::Home::Index.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'has 1 year on the index page' do
    rendered.scan('class="year-wrapper"').count.must_equal 1
  end

  it 'has 12 months on the index page' do
    rendered.scan('class="month"').count.must_equal 12
  end

  it 'properly highlights leap days' do
    rendered.scan('class="leap-day"').count.must_equal 0

    exp = Hash[
      year: Year.new(2000),
      formatter: FormatFactory.new.create(''),
      entry_list: CalendarEntryRepository.new,
      format: 'html'
    ]
    temp = Hanami::View::Template.new('apps/web/templates/home/index.html.erb')
    v = Web::Views::Home::Index.new(temp, exp)
    rendered2000 = v.render

    rendered2000.scan('class="leap-day"').count.must_equal 1
  end

  it 'if there are no calendar entries, displays an empty message' do
    repo.clear
    exp = Hash[year: Year.new(2000), formatter: FormatFactory.new.create(''), entry_list: repo, format: 'html']
    temp = Hanami::View::Template.new('apps/web/templates/home/index.html.erb')
    v = Web::Views::Home::Index.new(temp, exp)
    rendered_empty = v.render
    rendered_empty.scan('There are no calendar entries stored.').count.must_equal 1
  end

  it 'if there are entries, display them in a list' do
    repo.clear
    repo.create(name: 'Christmas', month: 12, day: 25)
    repo.create(name: 'Remembrance Day', month: 11, day: 11)
    exp = Hash[year: Year.new(2000), formatter: FormatFactory.new.create(''), entry_list: repo, format: 'html']
    temp = Hanami::View::Template.new('apps/web/templates/home/index.html.erb')
    v = Web::Views::Home::Index.new(temp, exp)
    rendered_holidays = v.render
    rendered_holidays.scan('2000-12-25 - Christmas').count.must_equal 1
    rendered_holidays.scan('2000-11-11 - Remembrance Day').count.must_equal 1
  end
end
