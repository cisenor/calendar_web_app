module Web::Views::Home
  class Index
    include Web::View

    def next_link
      link_to("/#{year.year + 1}",class: 'nav-button', id: 'next-year') do
        image('right-arrow.png')
      end
    end

    def home
      url = routes.root_path(year: year.year)
      link_to(url, class: 'nav-button') do
        image('home.png')
      end
    end

    def previous_link
      link_to("/#{year.year - 1}",class: 'nav-button', id: 'previous-year') do
        image('left-arrow.png')
      end
    end

    def style(day)
      style_tag = entry_list.style(day)
      formatter.style(style_tag)
    end
  end
end
