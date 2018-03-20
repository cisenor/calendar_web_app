require_relative '../../../spec_helper'

describe Web::Views::Home::Index do
  let(:exposures) { Hash[format: :html] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/home/index.html.erb') }
  let(:view)      { Web::Views::Home::Index.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'has proper header' do
    rendered.must_contain? '<div class="title">Calendar</div>'
  end
end
