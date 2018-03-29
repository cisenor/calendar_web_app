class CalendarEntryRepository < Hanami::Repository
  def style(day)
    return '' unless day.class == Date
    day_tag day
  end

  def delete_by_fixed(entry_name, entry_month, entry_day)
    found = find_by_fixed(entry_name, entry_month, entry_day)
    return false unless found
    delete(found.id)
  end

  def delete_by_occurrence(entry_name, entry_month, occurrence_week, occurrence_weekday)
    found = find_by_occurrence(entry_name, entry_month, occurrence_week, occurrence_weekday)
    return false unless found
    delete(found.id)
  end

  private

  def find_by_fixed(entry_name, entry_month, entry_day)
    calendar_entries.where(name: entry_name, month: entry_month, day: entry_day).first
  end

  def find_by_occurrence(entry_name, entry_month, occurrence_week, occurrence_weekday)
    calendar_entries.where(name: entry_name,
                           month: entry_month,
                           occurrence_week: occurrence_week,
                           occurrence_weekday: occurrence_weekday).first
  end

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
