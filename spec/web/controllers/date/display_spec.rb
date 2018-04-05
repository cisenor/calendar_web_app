require_relative '../../../spec_helper'
require 'minitest/pride'
describe Web::Controllers::Date::Display do
  let(:action) { Web::Controllers::Date::Display.new }
  let(:params) { Hash[year: 2018, month: 12, day: 12, 'warden' => warden] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end

  it 'fails with bad parameters' do
    response = action.call(Hash['warden' => warden])
    response[0].must_equal 422
    response = action.call(Hash[year: 2000, month: 2, day: 30, 'warden' => warden])
    response[0].must_equal 422
    action.params.errors.dig(:day).must_equal ['2000/2/30 is an invalid date.']
  end
end
