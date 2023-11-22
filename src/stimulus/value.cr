class Stimulus::Value
  getter controller_name : String
  getter value_name : String
  getter value : String

  def initialize(@controller_name, @value_name, @value)
  end

  def to_html_attrs(_tag, attrs)
    attrs[attr_name] = value
  end

  def to_s(io)
    io << attr_name
    io << "=\""
    io << value
    io << "\""
  end

  def attr_name
    "data-#{controller_name}-#{value_name}-value"
  end
end
