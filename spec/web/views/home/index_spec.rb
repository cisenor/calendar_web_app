require_relative '../../../spec_helper'

describe Web::Views::Home::Index do
  let(:exposures) { Hash[year: Year.new(2018)] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/home/index.html.erb') }
  let(:view)      { Web::Views::Home::Index.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'has proper header' do
    rendered.must_contain? '<div class="title">Calendar</div>'
  it 'has 1 year on the index page' do
    rendered.scan('class="year"').count.must_equal 1
  end

  it 'has 12 months on the index page' do
    rendered.scan('class="month"').count.must_equal 12
  end

  it 'has a form to add a calendar entry' do
    rendered.scan('class="add-entry-form"').count.must_equal 1
  end
end
