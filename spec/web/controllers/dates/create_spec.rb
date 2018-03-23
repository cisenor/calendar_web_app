require_relative '../../../spec_helper'

describe Web::Controllers::Dates::Create do
  let(:action) { Web::Controllers::Dates::Create.new }
  let(:repo) { CalendarEntryRepository.new }

  before do
    repo.clear
  end

  describe 'with valid parameters' do
    let(:params) { Hash[calendar_entry: { name: 'test123', month: 2, day: 2 }] }

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
    let(:empty_params) { Hash[calendar_entry: {}] }
    it 'returns a client error' do
      response = action.call(empty_params)
      response[0].must_equal 422
    end
    it 'sends errors back in params' do
      action.call(empty_params)
      errors = action.params.errors

      errors.dig(:calendar_entry, :name).must_equal ['is missing']
      errors.dig(:calendar_entry, :month).must_equal ['is missing']
    end
  end

  describe 'with invalid parameters' do
    let(:invalid_params) { Hash[calendar_entry: { name: 'test123', month: 0, day: 0 }] }
    it 'returns a client error' do
      response = action.call(invalid_params)
      response[0].must_equal 422
    end
    it 'sends errors back in params' do
      action.call(invalid_params)
      errors = action.params.errors

      errors.dig(:calendar_entry, :name).must_equal ['is missing']
      errors.dig(:calendar_entry, :month).must_equal ['is missing']
      errors.dig(:calendar_entry, :day).must_equal ['must be between 1 and 12']
    end
  end
end
