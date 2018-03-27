module Web::Controllers::Dates
  class CreateOccurrence
    include Web::Action

    params do
      required(:calendar_entry_occurrence).schema do
        required(:name).filled(:str?, size?: 1..32)
        required(:month).filled(:int?, included_in?: 1..12)
        required(:occurrence_week).filled(:int?, included_in?: 1..6)
        required(:occurrence_weekday).filled(:int?, included_in?: 0..6)
      end
    end

    def call(params)
      if params.valid?
        CalendarEntryRepository.new.create(params[:calendar_entry_occurrence])
        redirect_to routes.root_path
      else
        self.status = 422
      end
    end
  end
end
