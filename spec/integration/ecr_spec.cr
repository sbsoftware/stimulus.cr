require "../spec_helper"
require "ecr"

module Stimulus::Integration::ECRSpec
  class OtherController < Stimulus::Controller
  end

  class MyController < Stimulus::Controller
    values css_class: String
    targets :the_item
    outlets OtherController

    action :do_it do |event|
      console.log(event.params.message)
      this.theItemTarget.classList.toggle(this.cssClassValue)
    end
  end

  class MyView
    ECR.def_to_s(__DIR__ + "/ecr_spec/my_view.ecr")
  end

  describe "MyView.to_s" do
    it "should return the correct HTML" do
      expected = <<-HTML
      <div data-controller="stimulus--integration--ecr-spec--my" data-stimulus--integration--ecr-spec--my-css-class-value="the-class" data-stimulus--integration--ecr-spec--my-stimulus--integration--ecr-spec--other-outlet="#div_id">
        <div data-controller="stimulus--integration--ecr-spec--other" id="div_id"></div>
        <div data-stimulus--integration--ecr-spec--my-target="theItem">Test</div>
        <div data-stimulus--integration--ecr-spec--my-message-param="Hello World!" data-action="click->stimulus--integration--ecr-spec--my#do_it">Do it!</div>
      </div>

      HTML

      MyView.new.to_s.should eq(expected)
    end
  end
end
