module Web::Controllers::Dates
  class Create
    include Web::Action

    def call(params)
      CalendarEntryRepository.new.create(params[:calendar_entry])
      redirect_to routes.root_path
    end
  end
end
