require_relative '../../../spec_helper'

describe Web::Views::Home::Index do
  let(:exposures) { Hash[year: Year.new(2018), formatter: FormatFactory.new.create(''), entry_list: CalendarEntryList.new] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/home/index.html.erb') }
  let(:view)      { Web::Views::Home::Index.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'has 1 year on the index page' do
    rendered.scan('class="year"').count.must_equal 1
  end

  it 'has 12 months on the index page' do
    rendered.scan('class="month"').count.must_equal 12
  end

  it 'properly highlights leap days' do
    rendered.scan('class="leap-day"').count.must_equal 0

    exp = Hash[year: Year.new(2000), formatter: FormatFactory.new.create(''), entry_list: CalendarEntryList.new]
    temp = Hanami::View::Template.new('apps/web/templates/home/index.html.erb')
    v = Web::Views::Home::Index.new(temp, exp)
    rendered2000 = v.render

    rendered2000.scan('class="leap-day"').count.must_equal 1
  end

  it 'has a form to add a calendar entry' do
    rendered.scan('class="add-entry-form"').count.must_equal 1
  end

end
