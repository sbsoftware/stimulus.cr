require "../spec_helper"
require "ecr"

module Stimulus::Integration::ECRSpec
  class MyController < Stimulus::Controller
    values css_class: String
    targets :the_item

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
      <div data-controller="my" data-my-css-class-value="the-class">
        <div data-my-target="theItem">Test</div>
        <div data-my-message-param="Hello World!" data-action="click->my#do_it">Do it!</div>
      </div>

      HTML

      MyView.new.to_s.should eq(expected)
    end
  end
end
