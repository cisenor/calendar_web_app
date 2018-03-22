
module Format::Helpers::Web
  private
  SEPARATOR = ''.freeze

  def custom_format(day)
    '---' + day.to_s
  end
end
