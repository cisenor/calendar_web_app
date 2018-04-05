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
UserRepository.new.clear
login_as(UserRepository.new.create(name: 'Test User', github_id: '123121'))