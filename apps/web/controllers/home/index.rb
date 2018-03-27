
require_relative '../../../../lib/calendar/formatters/format_factory'
module Web::Controllers::Home
  class Index
    include Web::Action
    expose :year, :formatter, :entry_list
    def call(params)
      year = params[:year]
      year ||= Date.today.year
      @year = Year.new(year.to_i)
      @formatter = FormatFactory.new.create(params[:format])
      @entry_list = CalendarEntryRepository.new
    end
  end
end
