module Web::Controllers::Dates
  class Create
    include Web::Action

    params do
      required(:calendar_entry_fixed).schema do
        required(:name).filled(:str?, size?: 1..32)
        required(:month).filled(:int?, included_in?: 1..12)
        required(:day).filled(:int?, included_in?: 1..31)
        optional(:entry_access).filled
      end
    end

    def call(params)
      return self.status = 422 unless params.valid?
      create_new(params[:calendar_entry_fixed])
      redirect_to routes.root_path
    end

    private

    def create_new(entry)
      if current_user && entry[:entry_access] == 'Private'
        create_private(entry)
      else
        create_public(entry)
      end
    end

    def create_public(entry)
      CalendarEntryRepository.new.create_public(entry)
    end

    def create_private(entry)
      entry = entry.merge(Hash[user: current_user])
      CalendarEntryRepository.new.create_private(entry)
    end
  end
end
