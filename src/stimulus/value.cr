class Stimulus::Value
  getter controller_name : String
  getter value_name : String
  getter value : String

  def initialize(@controller_name, @value_name, @value)
  end

  def to_html_attrs(_tag, attrs)
    attrs["data-#{controller_name}-#{value_name}-value"] = value
  end
end
