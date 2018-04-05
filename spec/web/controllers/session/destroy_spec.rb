require_relative '../../../spec_helper'

describe Web::Controllers::Session::Destroy do
  include Rack::Test::Methods
  let(:action) { Web::Controllers::Session::Destroy.new }
  let(:params) { Hash[] }
end
