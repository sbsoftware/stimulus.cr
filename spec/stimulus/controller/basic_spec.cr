require "../../spec_helper"

module Stimulus::Controller::BasicSpec
  class MyController < Stimulus::Controller
    values css_class: String, interval: Number, params: Object, decode: Boolean, args: Array
    targets :the_item

    js_method connect do
      console.log("hooray!")
    end
  end

  describe MyController do
    it "should provide #css_class_value" do
      MyController.css_class_value("some-thing").should be_a(Stimulus::Value)
    end

    it "should provide #the_item_target" do
      MyController.the_item_target.should be_a(Stimulus::Target)
    end

    describe ".to_js" do
      it "should return the correct JS code" do
        expected = <<-JS.squish
        class MyController extends Controller {
          static values = {cssClass: String, interval: Number, params: Object, decode: Boolean, args: Array};
          static targets = ["theItem"];

          connect() {
            console.log("hooray!");
          }
        }
        JS

        MyController.to_js.should eq(expected)
      end
    end
  end
end
