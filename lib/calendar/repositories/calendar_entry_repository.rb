class CalendarEntryRepository < Hanami::Repository
  def style(day)
    return '' unless day.class == Date
    return :leap if day.month == 2 && day.day == 29
    return :friday13 if day.wday == 5 && day.day == 13
    return :holiday if holiday day
    :none
  end

  private

  def holiday(day)
    calendar_entries.where(month: day.month, day: day.day).to_a.any?
  end
end
