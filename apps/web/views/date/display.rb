module Web::Views::Date
  class Display
    include Web::View

    def previous_day
      yesterday = date - 1
      url = routes.display_date_path(year: yesterday.year, month: yesterday.month, day: yesterday.day)
      link_to(url, class: 'nav-button') do
        image('left-arrow.png')
      end
    end

    def next_day
      tomorrow = date + 1
      url = routes.display_date_path(year: tomorrow.year, month: tomorrow.month, day: tomorrow.day)
      link_to(url, class: 'nav-button') do
        image('right-arrow.png')
      end
    end

    def home
      url = routes.root_path(year: date.year)
      link_to(url, class: 'nav-button') do
        image('home.png')
      end
    end

    def header
      css = 'title ' + formatter.style(repo.style(date))
      title = date.strftime('%B %-d, %Y')
      raw "<div class=\"#{css}\">#{title}</div>"
    end
  end
end
