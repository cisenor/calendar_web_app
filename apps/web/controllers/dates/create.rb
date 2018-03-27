module Web::Controllers::Dates
  class Create
    include Web::Action

    params do
      required(:calendar_entry_fixed).schema do
        required(:name).filled(:str?, size?: 1..32)
        required(:month).filled(:int?, included_in?: 1..12)
        required(:day).filled(:int?, included_in?: 1..31)
      end
    end
    def call(params)
      if params.valid?
        CalendarEntryRepository.new.create(params[:calendar_entry_fixed])
        redirect_to routes.root_path
      else
        self.status = 422
      end
    end
  end
end
