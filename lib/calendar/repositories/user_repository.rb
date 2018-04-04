class UserRepository < Hanami::Repository
  def self.auth!(auth_hash)
    repo = UserRepository.new
    info = auth_hash[:info]
    github_id = auth_hash[:uid]
    attrs = { name: info[:nickname], email: info[:email] }
    if user = repo.users.where(github_id: attrs[:github_id]).first
      user.update(attrs)
      update user
    else
      repo.create(attrs.merge(github_id: github_id))
    end
  end
end
