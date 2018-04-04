require_relative '../../../spec_helper'

describe Web::Controllers::Dates::Delete do
  let(:action) { Web::Controllers::Dates::Delete.new }
  let(:params) { Hash[id: 1, 'warden' => warden] }
  
  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 302
  end

  it 'fails without an id' do
    params[:id] = nil
    response = action.call(params)
    response[0].must_equal 422
  end
end
