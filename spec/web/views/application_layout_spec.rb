require 'spec_helper'

describe Web::Views::ApplicationLayout do
  let(:layout)   { Web::Views::ApplicationLayout.new(template, {}) }
  let(:rendered) { layout.render }
  let(:template) { Hanami::View::Template.new('apps/web/templates/application.html.erb') }

  it 'contains application name' do
    rendered.scan('<div class="title">Calendar</div>').count.must_equal 1
  end
end
