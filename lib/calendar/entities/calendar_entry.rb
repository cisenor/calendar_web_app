class CalendarEntry < Hanami::Entity
  
  def date(year)
    return date_from_fixed year if @attributes.key?(:day)
    return date_from_occurrence year if @attributes.key?(:occurrence_week)
    fail 'Calendar entry entity needs either a day or an occurrence_week'
  end

  def display(year)
    date(year).to_s + ' - ' + name
  end

  private

  def date_from_fixed(year)
    month = @attributes.fetch(:month)
    day = @attributes.fetch(:day)
    Date.new(year, month, day)
  end

  def date_from_occurrence(year)
    month = @attributes.fetch(:month)
    occurrence_week = @attributes.fetch(:occurrence_week)
    occurrence_weekday = @attributes.fetch(:occurrence_weekday)
    d = Date.new(year, month, 1)
    d = d.next_day until d.wday == occurrence_weekday
    return d if occurrence_week == 1
    d + (7 * (occurrence_week - 1))
  end
end
