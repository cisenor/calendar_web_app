require_relative '../../../spec_helper'

describe Web::Controllers::Dates::Create do
  let(:action) { Web::Controllers::Dates::Create.new }
  let(:repo) { CalendarEntryRepository.new }
  let(:user_repo) { UserRepository.new }

  def before_setup
    repo.clear
    user_repo.clear
  end

  describe 'with valid parameters' do
    let(:params) { Hash[calendar_entry_fixed: { name: 'test123', month: 2, day: 2, entry_access: 'Public' }, 'warden' => warden] }

    it 'creates a new public calendar entry' do
      action.call(params)
      entry = repo.last
      entry.name.must_equal 'test123'
    end

    it 'creates a new private calendar entry' do
      user = get_test_user
      login_as user
      action.call(Hash[calendar_entry_fixed: { name: 'test234', month: 2, day: 1, entry_access: 'Private' }, 'warden' => warden])
      Warden.test_reset!
      entry = repo.last
      entry.name.must_equal 'test234'
      entry.user_id.must_equal user.id
      repo.all.size.must_equal 1
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
