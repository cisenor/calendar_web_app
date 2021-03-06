require_relative '../../../spec_helper'

describe Web::Controllers::Dates::Index do
  let(:action) { Web::Controllers::Dates::Index.new }
  let(:params) { Hash['warden' => warden] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
