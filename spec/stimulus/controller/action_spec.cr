require "../../spec_helper"

module Stimulus::Controller::ActionSpec
  class MyController < Stimulus::Controller
    targets :my

    action :do_it do
      target = this.myTarget

      target.classList.toggle("some-class")
    end
  end

  class ForwardingController < Stimulus::Controller
    macro js_method(name, **opts, &blk)
      def self.forwarded_js_method_opts
        {{opts}}
      end
    end

    action :do_it, strict: true do
    end
  end

  describe ".to_js" do
    it "should return the correct JS code" do
      expected = <<-JS.squish
      class Stimulus_Controller_ActionSpec_MyController extends Controller {
        static targets = ["my"];

        do_it() {
          var target;
          target = this.myTarget;
          target.classList.toggle("some-class");
        }
      }
      JS

      MyController.to_js.should eq(expected)
    end
  end

  describe ".action" do
    it "forwards named options to js_method" do
      ForwardingController.forwarded_js_method_opts.should eq({strict: true})
    end
  end
end
