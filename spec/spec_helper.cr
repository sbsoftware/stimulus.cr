require "spec"
require "../src/stimulus"

class String
  def squish
    split(/\n\s*/).join
  end
end
