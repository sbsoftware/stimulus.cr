class Stimulus::Target
  getter controller_name : String
  getter target_name : String

  def initialize(@controller_name, @target_name)
  end

  def to_html_attrs(_tag, attrs)
    attrs["data-#{controller_name}-target"] = target_name
  end
end
