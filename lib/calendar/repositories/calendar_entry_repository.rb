class CalendarEntryRepository < Hanami::Repository
  def style(day)
    return '' unless day.class == Date
    day_tag day
  end

  def sorted(year)
    calendar_entries.to_a.sort do |a, b|
      diff = a.date(year) - b.date(year)
      next diff unless diff.zero?
      a.name.casecmp b.name
    end
  end

  private

  def day_tag(day)
    return :leap if day.month == 2 && day.day == 29
    return :friday13 if day.wday == 5 && day.day == 13
    return :holiday if holiday? day
    :none
  end

  def holiday?(day)
    holiday = calendar_entries.where(month: day.month, day: day.day).to_a.any?
    return holiday if holiday
    occurrence? day
  end

  def occurrence?(day)
    wkday = day.wday
    # If the first weekday:
    nth = (day.day / 7) + 1
    calendar_entries.where(
      month: day.month,
      occurrence_week: nth,
      occurrence_weekday: wkday
    ).to_a.any?
  end
end
