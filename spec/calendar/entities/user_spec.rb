require_relative '../../spec_helper'

describe User do
  it 'can be created properly' do
    UserRepository.new.clear
    user = UserRepository.new.create(name: 'Test123', github_id: '1231231', unknown_field: 'schmoobles')
    proc { user.unknown_field }.must_raise NoMethodError
    user.name.must_equal 'Test123'
    user.github_id.must_equal '1231231'
  end
end
