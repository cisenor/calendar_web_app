module Web::Views::Home
  class Index
    include Web::View

    def get_style(day)
      formatter.get_style(day)
    end
  end
end
