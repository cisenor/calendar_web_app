require_relative '../../../spec_helper'

describe Web::Controllers::Dates::Add do
  let(:action) { Web::Controllers::Dates::Add.new }
  let(:params) { Hash['warden' => warden] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
