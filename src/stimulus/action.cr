class Stimulus::Action
  ATTR_NAME = "data-action"

  getter event : String
  getter controller_name : String
  getter action_name : String

  def initialize(@event, @controller_name, @action_name)
  end

  def to_html_attrs(_tag, attrs)
    attrs["data-action"] = attr_value
  end

  def to_s(io)
    io << ATTR_NAME
    io << "=\""
    io << attr_value
    io << "\""
  end

  def attr_value
    "#{event}->#{controller_name}##{action_name}"
  end
end
