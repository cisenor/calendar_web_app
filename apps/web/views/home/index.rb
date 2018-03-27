module Web::Views::Home
  class Index
    include Web::View

    def next_link
      raw "<a href=\"/#{year.year + 1}\" id=\"next-year\">#{ image 'right-arrow.png'} </a>"
    end

    def previous_link
      raw "<a href=\"/#{year.year - 1}\" id=\"previous-year\">#{ image 'left-arrow.png' }</a>"
    end

    def style(day)
      style_tag = entry_list.style(day)
      formatter.style(style_tag)
    end
  end
end
