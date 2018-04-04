# Require this file for unit tests
ENV['HANAMI_ENV'] ||= 'test'
require_relative '../config/environment'
require 'minitest/autorun'
require 'minitest/reporters'
require 'warden'
include Warden::Test::Helpers
include Warden::Test::Mock
login_as(Hash[name:'TestUser'])
Minitest.after_run do
  Warden.test_reset!
end
Minitest::Reporters.use!
Hanami.boot
