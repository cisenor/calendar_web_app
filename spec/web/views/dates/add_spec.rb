require_relative '../../../spec_helper'

describe Web::Views::Dates::Add do
  let(:exposures) { Hash[format: :html] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/dates/add.html.erb') }
  let(:view)      { Web::Views::Dates::Add.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #format' do
    view.format.must_equal exposures.fetch(:format)
  end
end
