require_relative '../../../spec_helper'

describe Web::Views::Home::Index do
  let(:exposures) { Hash[format: :html] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/home/index.html.erb') }
  let(:view)      { Web::Views::Home::Index.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'has 1 year on the index page' do 
    page.has_css?('.year', count: 1)
  end

  it 'has 12 months on the index page' do
    page.has_css?('.month', count: 12)
  end

  it 'has a form to add a calendar entry' do
    page.has_css?('form#add-entry', count: 1)
  end
end
