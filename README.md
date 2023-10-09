# stimulus

Write [Stimulus](https://stimulus.hotwired.dev/) controllers in Crystal. Based on [js.cr](https://github.com/sbsoftware/js.cr), designed for [compatibility](#compatibility-with-to_htmlcr) with [to_html.cr](https://github.com/sbsoftware/to_html.cr).

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     stimulus:
       github: sbsoftware/stimulus.cr
   ```

2. Run `shards install`

## Usage

```crystal
require "stimulus"
```

### Defining Controllers

You can define `values` and `targets` once. As `Stimulus::Controller`s are just [JS::Class](https://github.com/sbsoftware/js.cr#javascript-classes)es, you can add `js_method`s as much as you want - but if you want to reference them as controller actions in your Crystal code or templates, use the `action` macro.

```crystal
class LogController < Stimulus::Controller
  values :message, :css_class
  targets :element

  js_method :connect do
    console.log(this.messageValue)
  end

  action :do_it do
    this.elementTarget.classList.toggle(this.cssClassValue)
  end
end
```

### Referencing Controllers

All your `values`, `targets` and `action`s can be referenced via class methods of the controller:

```ecr
<div data-controller="<%= LogController.controller_name %> data-log-message-value="Hello World!">
  <div data-log-target="<%= LogController.element_target.target_name %>">Test!</div>
  <div data-action="click-><%= LogController.controller_name %>#<%= LogController.do_it_action.action_name %>">Go!</div>
</div>
```

### Compatibility with `to_html.cr`

When using [to_html.cr](https://github.com/sbsoftware/to_html.cr), things get even shorter. The controller and its value, target or action objects know how to fit into an HTML element as an attribute.

```crystal
div LogController, LogController.message_value("Hello World!") do
  div LogController.element_target do
    "Test!"
  end
  div LogController.do_it_action("click") do
    "Go!"
  end
end
```
