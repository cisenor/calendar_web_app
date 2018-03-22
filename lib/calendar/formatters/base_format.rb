class BaseFormat
  def initialize
    @highlights = {
      holiday: 'bold',
      leap: 'leap-day',
      friday13: 'friday-13',
      none: ''
    }
  end

  def style(style)
    @highlights.fetch(style, '')
  end
end
