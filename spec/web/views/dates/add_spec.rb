require_relative '../../../spec_helper'

describe Web::Views::Dates::Add do
  let(:params) do
    OpenStruct.new(
      valid?: false,
      error_messages: [
        'Name must be filled',
        'Month must be filled'
      ]
    )
  end
  let(:exposures) { Hash[params: params, format: :html, current_user: nil] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/dates/add.html.erb') }
  let(:view)      { Web::Views::Dates::Add.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'displays a list of errors when params contains errors' do
    rendered.must_include 'There was a problem with your submission'
    rendered.must_include 'Name must be filled'
    rendered.must_include 'Month must be filled'
  end
end
