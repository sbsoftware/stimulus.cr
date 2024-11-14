class Stimulus::Outlet
  getter host_controller : Stimulus::Controller.class
  getter outlet_controller : Stimulus::Controller.class
  getter selector : String

  def initialize(@host_controller, @outlet_controller, @selector); end

  def to_html_attrs(_tag, attrs)
    attrs[attr_name] = selector
  end

  def attr_name
    "data-#{host_controller.controller_name}-#{outlet_controller.controller_name}-outlet"
  end

  def to_s(io)
    io << attr_name
    io << "=\""
    io << selector
    io << "\""
  end
end
