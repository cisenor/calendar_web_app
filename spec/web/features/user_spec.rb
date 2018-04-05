require_relative '../../spec_helper'
describe 'Users' do
  let(:user_repo)     { UserRepository.new }
  let(:entry_repo)    { CalendarEntryRepository.new }
  describe 'when a user is logged in' do
    def before_setup
      entry_repo.clear
      user_repo.clear
    end

    it 'can see public entries' do
      pub = create_public_entry
      user = get_test_user
      entries = entry_repo.entries(user)
      entries.size.must_equal 1
      entries.first.name.must_equal pub.name
    end

    it 'can see private entries' do
      user = get_test_user
      pub = create_public_entry
      priv = create_private_entry(user)
      entries = entry_repo.entries(user)
      entries.size.must_equal 2
      entries.first.name.must_equal pub.name
      entries[1].name.must_equal priv.name
    end

    it 'can\'t see other users\' private entries' do
      user1 = get_test_user
      user2 = get_test_user
      create_private_entry(user1)
      entries = entry_repo.entries(user2)
      entries.size.must_equal 0
    end

    it 'when not logged in, can see only public entries' do
      entry_repo.clear
      user_repo.clear
      user = get_test_user
      create_private_entry(user)
      pub = create_public_entry
      entries = entry_repo.entries
      entries.size.must_equal 1
      entries.first.name.must_equal pub.name
    end
  end
end
