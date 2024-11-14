require "js"
require "./value"
require "./target"
require "./action"
require "./param"
require "./outlet"

class Stimulus::Controller < JS::Class
  ATTR_NAME = "data-controller"

  js_extends Controller

  macro values(**names)
    {% for name in names %}
      def self.{{name.id}}_value(value)
        ::Stimulus::Value.new(controller_name, {{name.id.stringify.underscore.gsub(/_/, "-")}}, value)
      end
    {% end %}

    static values = { {{names.map { |n, k| "#{n.id.stringify.camelcase(lower: true)}: #{k}".id }.splat}} }
  end

  macro targets(*names)
    {% for name in names %}
      def self.{{name.id}}_target
        ::Stimulus::Target.new(controller_name, {{name.id.stringify.camelcase(lower: true)}})
      end
    {% end %}

    static targets = [{{names.map(&.id).map(&.stringify).map(&.camelcase(lower: true)).splat}}]
  end

  macro outlets(*outlet_controllers)
    {% for outlet_controller in outlet_controllers %}
      def self.{{outlet_controller.names.last.underscore}}_outlet(selector)
        ::Stimulus::Outlet.new(self, {{outlet_controller}}, selector)
      end
    {% end %}

    static outlets = [{{outlet_controllers.splat}}].map(&.controller_name)
  end

  macro action(name, &blk)
    def self.{{name.id}}_action(event)
      ::Stimulus::Action.new(event, controller_name, {{name.id.stringify}})
    end

    js_method {{name}} {{blk}}
  end

  def self.param(name, value)
    ::Stimulus::Param.new(controller_name, name, value)
  end

  def self.controller_name
    name.chomp("Controller").split("::").map do |part|
      part.underscore.gsub(/_/, "-")
    end.join("--")
  end

  def self.to_html_attrs(_tag, attrs)
    attrs[ATTR_NAME] = controller_name
  end

  def self.to_s(io)
    io << ATTR_NAME
    io << "=\""
    io << controller_name
    io << "\""
  end
end
