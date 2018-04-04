require_relative '../../../spec_helper'

describe Web::Controllers::Dates::Create do
  let(:action) { Web::Controllers::Dates::Create.new }
  let(:repo) { CalendarEntryRepository.new }

  describe 'with valid parameters' do
    let(:params) { Hash[calendar_entry_fixed: { name: 'test123', month: 2, day: 2 }, 'warden' => warden] }

    it 'creates a new calendar entry' do
      action.call(params)
      entry = repo.last
      entry.name.must_equal 'test123'
    end

    it 'redirects the user' do
      response = action.call(params)
      response[0].must_equal 302
      response[1]['Location'].must_equal '/'
    end
  end

  describe 'with empty parameters' do
    let(:empty_params) { Hash[calendar_entry_fixed: {}, 'warden' => warden] }
    it 'returns a client error' do
      response = action.call(empty_params)
      response[0].must_equal 422
    end
    it 'sends errors back in params' do
      action.call(empty_params)
      errors = action.params.errors

      errors.dig(:calendar_entry_fixed, :name).must_equal ['is missing', 'size must be within 1 - 32']
      errors.dig(:calendar_entry_fixed, :month).must_equal ['is missing', 'must be one of: 1 - 12']
    end
  end

  describe 'with invalid parameters' do
    let(:invalid_params) { Hash[calendar_entry_fixed: { name: '1234567890123456789012345678901234567890', month: -1, day: 0 }, 'warden' => warden] }
    it 'returns a client error' do
      response = action.call(invalid_params)
      response[0].must_equal 422
    end
    it 'sends errors back in params' do
      action.call(invalid_params)
      errors = action.params.errors

      errors.dig(:calendar_entry_fixed, :name).must_equal ['length must be within 1 - 32']
      errors.dig(:calendar_entry_fixed, :month).must_equal ['must be one of: 1 - 12']
      errors.dig(:calendar_entry_fixed, :day).must_equal ['must be one of: 1 - 31']
    end
  end
end
