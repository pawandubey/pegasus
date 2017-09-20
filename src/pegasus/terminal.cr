require "./atoms/*"
require "./rule.cr"

module Pegasus
  class Terminal < Rule
    def initialize(@atom : Atoms::Base)
    end

    def match?(context : Context)
      @atom.match?(context)
    end

    def flatten
      [@atom]
    end
  end
end
