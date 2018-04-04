module Web::Controllers::Session
  class Failure
    include Web::Action

    def call(_params)
      self.status = 404
    end
  end
end
