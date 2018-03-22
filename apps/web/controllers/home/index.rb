
require_relative '../../../../lib/calendar/formatters/format_factory'
require_relative '../../../../lib/calendar/models/calendar_entry_list'
module Web::Controllers::Home
  class Index
    include Web::Action
    expose :year, :formatter, :entry_list
    def call(params)
      @year = Year.new(params[:year])
      @formatter = FormatFactory.new.create(params[:format])
      @entry_list = CalendarEntryList.new
    end
  end
end
