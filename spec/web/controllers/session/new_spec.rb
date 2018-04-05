require_relative '../../../spec_helper'

describe Web::Controllers::Session::New do
  before :all do
    Warden.test_mode!
  end
  after do
    Warden.test_reset!
  end
  let(:action) { Web::Controllers::Session::New.new }
  let(:params) { Hash['omniauth.auth' => Hash[uid: '12321', info: Hash[nickname: 'test user', email: 'fake@fake.com']]] }

  it 'is successful' do
    login_as get_test_user
    params['warden'] = warden
    response = action.call(params)
    Warden.test_reset!
    response[0].must_equal 302
  end
end
