require_relative '../../../spec_helper'

describe Web::Views::Dates::CreateOccurrence do
  let(:exposures) { Hash[format: :html] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/dates/create_occurrence.html.erb') }
  let(:view)      { Web::Views::Dates::CreateOccurrence.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #format' do
    view.format.must_equal exposures.fetch(:format)
  end
end
