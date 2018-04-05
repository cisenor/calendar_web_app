require_relative '../../../spec_helper'
require_relative '../../../../lib/calendar/models/year'

describe Web::Controllers::Home::Index do
  before {login_as UserRepository.new.all.first}
  let(:action) { Web::Controllers::Home::Index.new }
  let(:params) { Hash[year: 2018, 'warden' => warden] }
  let(:important_dates) { CalendarEntryRepository.new }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end

  it 'exposes the year object' do
    action.call(params)
    action.exposures[:year].year.must_equal 2018
  end

  it 'defaults to current year' do
    action.call(params)
    action.year == Year.new(2018)
  end

  it 'initializes the year parameter to a year parameter' do
    params = Hash[year: 2000, 'warden' => warden]
    action.call(params)
    action.year == Year.new(2000)
  end
end
