require_relative '../../../spec_helper'

describe Web::Controllers::Session::Failure do
  let(:action) { Web::Controllers::Session::Failure.new }
  let(:params) { Hash['warden' => warden] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 404
  end
end
