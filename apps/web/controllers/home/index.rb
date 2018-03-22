
require_relative '../../../../lib/calendar/formatters/format_factory'
module Web::Controllers::Home
  class Index
    include Web::Action
    expose :year, :formatter, :entry_list
    def call(params)
      @year = Year.new(params[:year])
      @formatter = FormatFactory.new.create(params[:format])
      @entry_list = CalendarEntryRepository.new
    end
  end
end
