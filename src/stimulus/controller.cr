require "js"
require "./value"
require "./target"
require "./action"

class Stimulus::Controller < JS::Class
  js_extends Controller

  macro values(*names)
    {% for name in names %}
      def self.{{name.id}}_value(value)
        Stimulus::Value.new(controller_name, {{name.id.stringify.underscore.gsub(/_/, "-")}}, value)
      end
    {% end %}

    static values = [{{names.map(&.id).map(&.stringify).map(&.camelcase(lower: true)).splat}}]
  end

  macro targets(*names)
    {% for name in names %}
      def self.{{name.id}}_target
        Stimulus::Target.new(controller_name, {{name.id.stringify.camelcase(lower: true)}})
      end
    {% end %}

    static targets = [{{names.map(&.id).map(&.stringify).map(&.camelcase(lower: true)).splat}}]
  end

  macro action(name, &blk)
    def self.{{name.id}}_action(event)
      Stimulus::Action.new(event, controller_name, {{name.id.stringify}})
    end

    js_method {{name}} {{blk}}
  end

  def self.controller_name
    name.split("::").last.chomp("Controller").underscore
  end

  def self.to_html_attrs(_tag, attrs)
    attrs["data-controller"] = controller_name
  end
end
