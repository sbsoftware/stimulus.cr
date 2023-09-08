class Stimulus::Action
  getter event : String
  getter controller_name : String
  getter action_name : String

  def initialize(@event, @controller_name, @action_name)
  end

  def to_html_attrs(_tag, attrs)
    attrs["data-action"] = "#{event}->#{controller_name}##{action_name}"
  end
end
