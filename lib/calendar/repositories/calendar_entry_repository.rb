class CalendarEntryRepository < Hanami::Repository
  def style(date)
    return ':none' unless date.class == Date
    day_tag date
  end

  # Return all public entries and any private entries created by the provided user.
  def entries(user = nil)
    entries = calendar_entries.where(user_id: nil).to_a
    entries.concat(calendar_entries.where(user_id: user.id)).to_s if user
    entries
  end

  def create_private(name, month, day, user)
    create(name: name, month: month, day: day, user_id: user.id)
  end

  def create_public(name, month, day)
    create(name: name, month: month, day: day)
  end

  def sorted(year, user = nil)
    entries(user).to_a.sort do |a, b|
      diff = a.date(year) - b.date(year)
      next diff unless diff.zero?
      a.name.casecmp b.name
    end
  end

  def entry_by_date(date)
    holidays = get_holidays(date)
    holidays.concat get_occurrences(date)
  end

  private

  def day_tag(date)
    return :leap if date.month == 2 && date.day == 29
    return :friday13 if date.wday == 5 && date.day == 13
    return :holiday if holiday? date
    :none
  end

  def holiday?(date)
    holiday = get_holidays(date).any?
    return holiday if holiday
    occurrence? date
  end

  def occurrence?(date)
    get_occurrences(date).to_a.any?
  end

  def get_occurrences(date)
    wkday = date.wday
    # If the first weekday:
    nth = ((date.day - 1) / 7) + 1
    calendar_entries.where(
      month: date.month,
      occurrence_week: nth,
      occurrence_weekday: wkday
    ).to_a
  end

  def get_holidays(date)
    calendar_entries.where(month: date.month, day: date.day).to_a
  end
end
