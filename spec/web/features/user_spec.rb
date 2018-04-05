require_relative '../../spec_helper'

describe 'when a user is logged in' do
  let(:user_repo)     { UserRepository.new }
  let(:entry_repo)    { CalendarEntryRepository.new }
  it 'can see public entries' do
    entry_repo.clear
    entry_repo.create_public('public date', 12, 12)
    user = user_repo.create(name: 'Test User', github_id: '123123')
    entries = entry_repo.entries(user)
    entries.size.must_equal 1
    entries.first.name.must_equal 'public date'
  end

  it 'can see private entries' do
    user_repo.clear
    user = user_repo.create(name: 'Test User', github_id: '1231231')
    entry_repo.clear
    entry_repo.create_private('private_date', 12, 12, user)
    entry_repo.create_public('public_date', 12, 12)
    entries = entry_repo.entries(user)
    entries.size.must_equal 2
    entries.first.name.must_equal 'public_date'
    entries[1].name.must_equal 'private_date'
  end

  it 'can\'t see other users\' private entries' do
    user_repo.clear
    entry_repo.clear
    user1 = user_repo.create(name: 'Test1', github_id: '12121212')
    user2 = user_repo.create(name: 'Test2', github_id: '23232323')
    entry_repo.create_private('private_test', 12, 12, user1)
    entries = entry_repo.entries(user2)
    entries.size.must_equal 0
  end
end

describe 'when a user is not logged in' do
  let(:user_repo)     { UserRepository.new }
  let(:entry_repo)    { CalendarEntryRepository.new }

  it 'can see only public entries' do
    entry_repo.clear
    entry_repo.create_public('public_test', 12, 12)
    user_repo.clear
    user = user_repo.create(name: 'Test1', github_id: '12121212')
    entry_repo.create_private('private_test', 12, 12, user)
    entries = entry_repo.entries
    entries.size.must_equal 1
    entries.first.name.must_equal 'public_test'
  end
end
