class Stimulus::Target
  getter controller_name : String
  getter target_name : String

  def initialize(@controller_name, @target_name)
  end

  def to_html_attrs(_tag, attrs)
    attrs[attr_name] = target_name
  end

  def to_s(io)
    io << attr_name
    io << "=\""
    io << target_name
    io << "\""
  end

  def attr_name
    "data-#{controller_name}-target"
  end
end
