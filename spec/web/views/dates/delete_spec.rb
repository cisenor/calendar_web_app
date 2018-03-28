require_relative '../../../spec_helper'

describe Web::Views::Dates::Delete do
  let(:exposures) { Hash[format: :html] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/dates/delete.html.erb') }
  let(:view)      { Web::Views::Dates::Delete.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #format' do
    view.format.must_equal exposures.fetch(:format)
  end
end
