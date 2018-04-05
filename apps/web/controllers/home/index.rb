
require_relative '../../../../lib/calendar/formatters/format_factory'
module Web::Controllers::Home
  
  class Index
    include Web::Action
    expose :year, :formatter, :entry_list

    params do
      optional(:current_user).schema do
        required(:name).filled(:str?, size?: 1..32)
        required(:github_id).filled(:str?)
      end
      optional(:year).filled(:int?)
      required(:format).filled
    end

    def call(params)
      year = params[:year]
      year ||= Date.today.year
      @year = Year.new(year.to_i)
      @formatter = FormatFactory.new.create(params[:format])
      @entry_list = CalendarEntryRepository.new
    end
  end
end
