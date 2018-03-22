require_relative 'base_format'

# Based on a type key, create a format object
class FormatFactory
  def create(type)
    case type
    when 'default'
      BaseFormat.new
    else
      BaseFormat.new
    end
  end
end
