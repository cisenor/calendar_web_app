require_relative '../../../spec_helper'

describe Web::Controllers::Dates::Delete do
  let(:action)      { Web::Controllers::Dates::Delete.new }
  let(:params)      { Hash[id: 1, 'warden' => warden] }
  let(:user_repo)   { UserRepository.new }
  let(:entry_repo)  { CalendarEntryRepository.new }

  it 'is successful' do
    entry = entry_repo.create_public(name: 'test1', month: 1, day: 1)
    response = action.call(id: entry.id, 'warden' => warden)
    response[0].must_equal 302
  end

  it 'fails without an id' do
    params[:id] = nil
    response = action.call(params)
    response[0].must_equal 422
  end

  describe 'Private entries' do
    it 'can\'t delete other user\'s private entries' do
      user1 = user_repo.create(name: 'test1', github_id: '12341234')
      user2 = user_repo.create(name: 'test2', github_id: '12345123')
      entry = entry_repo.create_private(name: 'user1\'s date', month: 12, day: 12, user: user1)
      login_as user2
      response = action.call(id: entry.id, 'warden' => warden)
      response[0].must_equal 422
    end
  end
end
