require "../../spec_helper"

module Stimulus::Controller::OutletsSpec
  class OtherController < Stimulus::Controller
  end

  class HostController < Stimulus::Controller
    outlets OtherController
  end

  describe "HostController.to_js" do
    it "should include the outlet definition in the JS code" do
      expected = <<-JS.squish
      class Stimulus_Controller_OutletsSpec_HostController extends Controller {
        static outlets = ["stimulus--controller--outlets-spec--other"];
      }
      JS

      HostController.to_js.should eq(expected)
    end
  end
end
