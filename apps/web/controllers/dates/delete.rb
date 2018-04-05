module Web::Controllers::Dates
  class Delete
    include Web::Action
    params do
      required(:id).filled
    end

    def call(params)
      if params.valid?
        if CalendarEntryRepository.new.safe_delete(params, current_user).nil?
          self.status = 422
        else
          redirect_to request.get_header("Referer") || '/'
        end
      else
        self.status = 422
      end
    end

    private

    def delete(params)
      self.status = 422 if CalendarEntryRepository.new.safe_delete(params, current_user).nil?
    end
  end
end
