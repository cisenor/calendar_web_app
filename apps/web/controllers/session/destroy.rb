module Web::Controllers::Session
  class Destroy
    include Web::Action

    def call(_params)
      warden.logout
      redirect_to routes.root_path
    end
  end
end
