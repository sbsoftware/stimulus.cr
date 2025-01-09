require "./stimulus/controller"

macro stimulus_controller(name, &blk)
  class {{name}} < ::Stimulus::Controller
    {{blk.body}}
  end
end
