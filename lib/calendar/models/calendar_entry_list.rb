class CalendarEntryList
  attr_reader :repo
  def initialize
    @repo = CalendarEntryRepository.new
  end

  def style(day)
    return '' unless day.class == Date
    return :leap if day.month == 2 && day.day == 29
    return :friday13 if day.wday == 5 && day.day == 13
    return :holiday if holiday day
    :none
  end

  def entries
    @repo.all
  end

  private

  def holiday(day)
    false
  end
end
