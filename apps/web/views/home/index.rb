module Web::Views::Home
  class Index
    include Web::View

    def style(day) 
      style_tag = entry_list.style(day)
      formatter.style(style_tag)
    end
  end
end
