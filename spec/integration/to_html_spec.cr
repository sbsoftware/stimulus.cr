require "../spec_helper"
require "to_html"

module Stimulus::Integration::ToHtmlSpec
  class OtherController < Stimulus::Controller
    action :do_something do
      this.classList.toggle("test")
    end
  end

  class MyController < Stimulus::Controller
    values my_str: String
    targets :the_item
    outlets OtherController

    action :do_it do
      this.theItemTarget.classList.toggle(this.myStrValue)
      this.otherOutlet
    end
  end

  class MyView
    ToHtml.class_template do
      div MyController, MyController.my_str_value("the-class"), MyController.other_controller_outlet("#div_id"), OtherController, id: "div_id" do
        div MyController.the_item_target do
          "Test"
        end
        div MyController.param("message", "Hello World!"), MyController.do_it_action("click") do
          "Do it!"
        end
      end
    end
  end

  describe "MyView.to_html" do
    it "should return the correct HTML" do
      expected = <<-HTML.squish
      <div data-controller="stimulus--integration--to-html-spec--my stimulus--integration--to-html-spec--other" data-stimulus--integration--to-html-spec--my-my-str-value="the-class" data-stimulus--integration--to-html-spec--my-stimulus--integration--to-html-spec--other-outlet="#div_id" id="div_id">
        <div data-stimulus--integration--to-html-spec--my-target="theItem">Test</div>
        <div data-stimulus--integration--to-html-spec--my-message-param="Hello World!" data-action="click->stimulus--integration--to-html-spec--my#do_it">Do it!</div>
      </div>
      HTML

      MyView.to_html.should eq(expected)
    end
  end
end
