# Require this file for unit tests
ENV['HANAMI_ENV'] ||= 'test'
require_relative '../config/environment'
require 'minitest/autorun'
require 'minitest/reporters'
require_relative '../lib/calendar/repositories/user_repository'
require 'warden'
include Warden::Test::Helpers
include Warden::Test::Mock
Minitest::Reporters.use!
Minitest.after_run do
  Warden.test_reset!
end
Hanami.boot

def get_test_user
  repo = UserRepository.new
  repo.create(name: 'Test', github_id: '12')
end

def create_public_entry
  entry_repo = CalendarEntryRepository.new
  entry_repo.create_public(name: 'public date', month: 12, day: 12)
end

def create_private_entry(user)
  entry_repo = CalendarEntryRepository.new
  entry_repo.create_private(name: 'private_date', month: 12, day: 12, user: user)
end
login_as(get_test_user)