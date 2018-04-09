require_relative '../../../../lib/calendar/formatters/format_factory'
module Web::Controllers::Date
  class Display
    include Web::Action
    include Hanami::Validations
    expose :date, :repo, :formatter, :entries
    params do
      required(:year).filled(:int?)
      required(:month).filled(:int?, included_in?: 1..12)
      required(:day).filled(:int?, included_in?: 1..31)
    end

    def call(params)
      return error_out unless params.valid?
      @year = params[:year]
      @month = params[:month]
      @day = params[:day]
      return error_out(params, :day, "#{@year}/#{@month}/#{@day} is an invalid date.") unless date_is_valid?(params)
      @formatter = FormatFactory.new.create(params[:format])
      @date = Date.new(@year, @month, @day)
      @repo = CalendarEntryRepository.new
      @entries = @repo.entry_by_date(@date)
    end

    private

    def date_is_valid?(params)
      days_in_month = Date.new(params[:year], params[:month], -1).day
      params[:day] <= days_in_month
    end

    def error_out(params = nil, symbol = nil, message = nil)
      params.errors.add(symbol, message) unless message.nil? || params.nil?
      self.status = 422
    end
  end
end
