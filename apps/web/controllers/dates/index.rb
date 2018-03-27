module Web::Controllers::Dates
  class Index
    include Web::Action
    expose :entry_list, :year
    def call(params)
      @entry_list = CalendarEntryRepository.new
      @year = Year.new(params[:year])
    end
  end
end
