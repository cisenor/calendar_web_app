module Web::Controllers::Dates
  class Delete
    include Web::Action
    params do
      required(:id).filled
    end

    def call(params)
      if params.valid?
        CalendarEntryRepository.new.delete(params[:id])
        redirect_to request.get_header("Referer") || '/'
      else
        self.status = 422
      end
    end
  end
end
