
require_relative '../../../../lib/calendar/formatters/format_factory'
module Web::Controllers::Home
  class Index
    include Web::Action
    expose :year, :formatter
    def call(params)
      @year = Year.new(params[:year])
    end
  end
end
