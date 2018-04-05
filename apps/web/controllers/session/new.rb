module Web::Controllers::Session
  class New
    include Web::Action

    def call(_params)
      user = UserRepository.auth!(auth_hash)
      warden.set_user user
      redirect_to routes.root_path
    end

    private

    def warden
      request.env['warden']
    end

    def auth_hash
      request.env['omniauth.auth']
    end

  end
end
