module Web::Views::Home
  class Index
    include Web::View

    def logout_button
      nav_button(
        routes.signout_path,
        'logout.png'
      )
    end

    def user_button
      raw "<span class=\"nav-button round\">#{current_user.name[0, 2].upcase}</span>"
    end

    def login_button
      nav_button(
        '/auth/github',
        'github-logo.png'
      )
    end

    def next_link
      link_to("/#{year.year + 1}", class: 'nav-button', id: 'next-year') do
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
      nav_button(
        routes.root_path(year.year - 1),
        'left-arrow.png',
        'nav-button',
        'previous-year'
      )
    end

    def style(day)
      style_tag = entry_list.style(day)
      formatter.style(style_tag)
    end

    private

    def nav_button(destination, image = nil, class_name = 'nav-button', id = nil)
      link_to(destination, class: class_name, id: id) do
        image(image) if image
      end
    end
  end
end
