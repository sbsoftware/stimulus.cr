require "../spec_helper"
require "to_html"

module Stimulus::Integration::ToHtmlSpec
  class MyController < Stimulus::Controller
    values :css_class
    targets :the_item

    action :do_it do
      this.theItemTarget.classList.toggle(this.cssClassValue)
    end
  end

  class MyView
    ToHtml.class_template do
      div MyController, MyController.css_class_value("the-class") do
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
      <div data-controller="my" data-my-css-class-value="the-class">
        <div data-my-target="theItem">Test</div>
        <div data-my-message-param="Hello World!" data-action="click->my#do_it">Do it!</div>
      </div>
      HTML

      MyView.to_html.should eq(expected)
    end
  end
end
