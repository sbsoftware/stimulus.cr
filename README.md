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
  values message: String, css_class: String
  targets :element

  js_method :connect do
    console.log(this.messageValue)
  end

  action :do_it do
    this.elementTarget.classList.toggle(this.cssClassValue)
  end
end
```

### Outlets

The `outlets` macro expects a list of other `Stimulus::Controller`s and provides you a method for each to define the outlet in your template.

```crystal
class SomeController < Stimulus::Controller
  action :do_some do
    console.log("Something!")
  end
end

class OtherController < Stimulus::Controller
end

class MyController < Stimulus::Controller
  outlets SomeController, OtherController

  action :do_it do
    this.someOutlet.do_some._call
  end
end

class MyView
  ToHtml.class_template do
    div SomeController, id: "some_id"

    div MyController, MyController.some_controller_outlet("#some_id"), MyController.do_it_action("click") do
      "Click me!"
    end
  end
end
```

### Printing Controllers

Just use `.to_js` to print the JS code of your controller where your want to have it.

```ecr
<html>
  <head>
    <script>
      <%= LogController.to_js %>
    </script>
  </head>
</html>
```

### Referencing Controllers

All your `values`, `targets` and `actions` can be referenced via class methods of the controller. Their `#to_s` methods present them as the HTML attribute strings they need to be:

```ecr
<div <%= LogController %> <%= LogController.message_value("Hello World!") <%= LogController.css_class_value("my_class") %>>
  <div <%= LogController.element_target %>>Test!</div>
  <div <%= LogController.do_it_action("click") %>>Go!</div>
</div>
```
=>
```html
<div data-controller="log" data-log-message-value="Hello World!" data-log-css-class-value="my_class">
  <div data-log-target="element">Test!</div>
  <div data-action="click->log#do_it">Go!</div>
</div>
```

### Compatibility with `to_html.cr`

When using [to_html.cr](https://github.com/sbsoftware/to_html.cr), things get even more comfortable. The controller and its value, target or action objects know how to fit into an HTML element as an attribute. The `to_html` attribute interface even manages adding multiple `controllers`/`values`/`targets`/`actions` to the same element, which would be cumbersome with plain ECR.

```crystal
div LogController, LogController.message_value("Hello World!"), LogController.css_class_value("my-class") do
  div LogController.element_target do
    "Test!"
  end
  div LogController.do_it_action("click") do
    "Go!"
  end
end
```
